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
