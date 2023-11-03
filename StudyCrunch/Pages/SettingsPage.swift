//
//  Settings.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/26/23.
//

import Foundation
import SwiftUI

struct SettingsPage: View {
  var body: some View {
    NavigationStack {
      List {
        ShareLink(item: appUrl)
      }
      .navigationTitle("Settings")
    }
  }
}

#Preview {
  SettingsPage()
}
