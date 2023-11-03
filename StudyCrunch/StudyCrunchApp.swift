//
//  StudyCrunchApp.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import SwiftUI

@main
struct StudyCrunchApp: App {
  @State var credModalOpen = true
  var body: some Scene {
    WindowGroup {
      ContentView()
<<<<<<< HEAD
=======
        .sheet(isPresented: $credModalOpen) {
          Onboarding(open: $credModalOpen)
      }
>>>>>>> 8d63a139293ab1b05d592af276239aa569f02cb8
    }
  }
}
