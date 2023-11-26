//
//  FatButton.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI

struct FatButton: View {
  var label: String
  var action: () -> ()
  
  init(_ label: String, _ action: @escaping () -> Void) {
    self.label = label
    self.action = action
  }
    var body: some View {
      Button(action: action) {
        Text(label)
          .fontSize(17, .medium, .white)
          .padding(.horizontal, 24)
          .padding(.vertical, 14)
          .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.accentColor))
      }
      .buttonStyle(.plain)
    }
}

