//
//  PurchasableItemView.swift
//  StudyCrunch
//
//  Created by Jun Gu on 12/25/23.
//

import SwiftUI
import StoreKit

struct PurchasableItemView: View {
  @ObservedObject var storeKit: StoreKitManager
  @State var isPurchased: Bool = false
  var product: Product

  var body: some View {
    VStack {
      if isPurchased {
        Text (Image (systemName: "checkmark"))
          .bold()
          .padding (10)
      } else {
        Text (product.displayPrice)
          .padding (10)
          .onChange(of: storeKit.purchasedCourses) { course in
            Task {
              isPurchased = (try? await storeKit.isPurchased(product)) ?? false
            }
          }
      }
    }
  }
}

