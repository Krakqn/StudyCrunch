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

  @Environment(\.openURL) var openURL

  var body: some View {
    NavigationView {
      VStack {
        Button {
          isFAQPanelPresented.toggle()
        } label: {
          MenuOption(symbol: "❓", name: "FAQ", description: "Frequently Asked Questions")
            .padding(.horizontal)
        }

        Button {
          openURL(feedbackUrl)
        } label: {
          MenuOption(symbol: "💭", name: "Feedback", description: "Feedback or Request Subjects")
            .padding(.horizontal)
        }

        Button {
          openURL(appUrl)
        } label: {
          HStack() {
            Image(.discordIcon).resizable().scaledToFit().frame(width: 40)
            VStack(alignment: .leading, spacing: 2) {
              Text("Join our discord!").fontSize(18, .semibold)
              Text("This is your invite to a community of trailblazers and problem solvers!").fontSize(16).opacity(0.75)
            }
            .padding(.leading, 5)
            Spacer(minLength: 0)
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 12)
          .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color("discordColor").opacity(0.25)))
          .padding(.horizontal)
        }
        .buttonStyle(.plain)

        Spacer()
      }
      .navigationTitle("About")
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
