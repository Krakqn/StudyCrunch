//
//  MenuOption.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/25/23.
//

import Foundation
import SwiftUI

struct MenuOption: View {
  var symbol: String?
  var icon: String?
  var name: String
  var description: String?
  var disabled = false
  var accessoryIcon: String? = nil

  init(symbol: String? = nil, icon: String? = nil, name: String, description: String? = nil, disabled: Bool = false, accessoryIcon: String? = nil) {
    self.symbol = symbol
    self.icon = icon
    self.name = name
    self.description = description
    self.disabled = disabled
    self.accessoryIcon = accessoryIcon
  }

  var body: some View {
    HStack(spacing: 15) {
      if let icon = icon {
        Image(systemName: icon)
      } else if let symbol = symbol {
        Text(symbol)
          .font(.system(size: 30))
          .frame(width: 40)
      }
      VStack(alignment: .leading, spacing: 3) {
        Text(name)
          .font(.system(size: 20).bold())
        if let description = description {
          Text(description)
            .font(.system(size: 15))
            .opacity(0.8)
        }
      }
      if let accessoryIcon {
        Spacer()
        Image(systemName: accessoryIcon)
          .padding()
      }
    }
    .padding()
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    .frame(height: 80)
    .background(Color("BackgroundColor"))
    .foregroundColor(Color("ForegroundColor"))
    .cornerRadius(10)
    .opacity(disabled ? 0.6 : 1.0)
  }
}
