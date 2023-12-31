//
//  StoreKitManager.swift
//  StudyCrunch
//
//  Created by Jun Gu on 12/24/23.
//

import Foundation
import StoreKit
import OSLog

class StoreKitManager: ObservableObject {

  @Published var storeProducts: [Product] = []
  @Published var purchasedCourses: [Product] = []

  private let logger = Logger(subsystem: "StudyCrunch", category: "StoreKitManager")

  var updateListenerTask: Task<Void, Error>? = nil

  private let productDict: [String : String]

  init() {
    // check the path for the plist
    if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
       //get the list of products
       let plist = FileManager.default.contents(atPath: plistPath) {
      productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String]) ?? [:]
    } else {
      productDict = [:]
    }

    updateListenerTask = listenForTransactions()
    
    Task {
      await requestProducts()
      await updateCustomerProductStatus()
    }
  }

  deinit {
    updateListenerTask?.cancel()
  }

  func listenForTransactions() -> Task<Void, Error> {
    return Task.detached {
      //iterate through transactions that don't come from a direct call to 'purchase()'
      for await result in Transaction.updates {
        do {
          let transaction = try self.checkVerified(result)
          //the transaction is verified, deliver the content to the user 
          await self.updateCustomerProductStatus()
          //Always finish a transaction
          await transaction.finish()
        } catch {
          //storekit has a transaction that fails verification, don't delvier content to the user
          self.logger.error("Transaction failed verification")
        }
      }
    }
  }

  @MainActor
  func requestProducts () async {
    do {
      //using the Product static method products to retrieve the list of products
      storeProducts = try await Product.products(for: productDict.values)
      // iterate the "type" if there are multiple product types.
    } catch {
      self.logger.error("Failed - error retrieving products \(error)")
    }
  }

  @discardableResult
  func purchase(_ product: Product) async throws -> Transaction? {
    //make a purchase request - optional parameters available
    let result = try await product.purchase()

    // check the results
    switch result {
    case . success(let verificationResult):
      //Transaction will be verified for automatically using JWT(jwsRepresentation) - we can check the result
      let transaction = try checkVerified(verificationResult)
      //the transaction is verified, deliver the content to the user 
      await updateCustomerProductStatus()
      //always finish a transaction - performance 
      await transaction.finish()
      return transaction
    case .userCancelled, .pending:
      return nil
    default:
      return nil
    }
  }

  //Generics - check the verificationResults
  func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
    //check if JWS passes the StoreKit verification
    switch result {
    case .unverified:
      //failed verificaiton|
      throw StoreError.failedVerification
    case .verified(let signedType):
      //the result is verified, return the unwrapped value
      return signedType
    }
  }

  @MainActor func updateCustomerProductStatus() async {
    var purchasedCourses: [Product] = []
    //iterate through all the ser's purchased products
    for await result in Transaction.currentEntitlements {
      do {
        //again check if transaction is verified
        let transaction = try checkVerified(result)
        // since we only have one type of producttype - nonconsumables - check if any storeProducts matches the transaction.productID then add to the purchasedCourses
        if let course = storeProducts.first(where: { $0.id == transaction.productID}) {
          purchasedCourses.append(course)
        }
        Global.unlockEverything()
      } catch {
        //storekit has a transaction that fails verification, don't delvier content to the user
        logger.error("Transaction failed verification")
      }
      //finally assign the purchased products
      self.purchasedCourses.removeAll()
      self.purchasedCourses.append(contentsOf: purchasedCourses)
    }
  }

  //check if product has already been purchased 
  func isPurchased(_ product: Product) async throws -> Bool {
    //as we only have one product type grouping .nonconsumable - we check if it belongs to the purchasedCourses which ran init()
    return purchasedCourses.contains(product)
  }
}

public enum StoreError: Error {
  case failedVerification
}
