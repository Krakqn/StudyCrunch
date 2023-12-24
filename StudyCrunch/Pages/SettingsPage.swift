//
//  Settings.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/26/23.
//

import Foundation
import SwiftUI

struct SettingsPage: View {
  @State var isFAQPanelPresented = false
  @StateObject var storeKit = StoreKitManager()

  var body: some View {
    NavigationView {
      VStack {
        // add discord button here
        Button {
          isFAQPanelPresented.toggle()
        } label: {
          MenuOption(symbol: "❓", name: "FAQ", description: "Frequently Asked Questions")
            .padding(.horizontal)
        }

        ForEach(storeKit.storeProducts) { product in
          HStack {
            Text("\(product.displayName):").foregroundStyle(.white)
              .padding(.leading, 55)
            Spacer()
            Button {
              Task {
                try await storeKit.purchase(product)
              }
            } label: {
              PurchasableItemView(storeKit: storeKit, product: product)
            }
          }
          .padding()
          .frame(maxWidth: .infinity, alignment: .leading)
          .frame(height: 80)
          .background(Color("BackgroundColor"))
          .cornerRadius(10)
          .padding(.horizontal)
        }

        Spacer()
      }
      .navigationTitle("Settings")
    }
    .sheet(isPresented: $isFAQPanelPresented) {
      NavigationView {
        FAQPanel(open: $isFAQPanelPresented)
          .navigationBarTitle("Frequently Asked Questions", displayMode: .inline)

      }
    }
  }
}

#Preview {
  SettingsPage()
    .environment(\.colorScheme, .light)
}
