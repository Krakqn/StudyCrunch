//
//  MenuOption.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/25/23.
//

import Foundation
import SwiftUI

struct MenuOption: View {
  var emoji: String?
  var icon: String?
  var name: String
  var description: String?
  var access: Bool
  
  var body: some View {
    HStack(spacing: 15) {
      if let icon = icon {
        Image(systemName: icon)
      } else if let emoji = emoji {
        Text(emoji)
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
    }
    .padding()
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    .background(Color("BackgroundColor"))
    .foregroundColor(Color("ForegroundColor"))
    .opacity(access ? 1.0 : 0.6) //greys out the button if user doesn't have proper access
    .cornerRadius(10)
  }
}
