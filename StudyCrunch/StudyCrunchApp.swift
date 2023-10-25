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
            //ContentView()
            CourseHome()
                .sheet(isPresented: $credModalOpen) {
                    Onboarding(open: $credModalOpen)
                }
        }
    }
}

//struct ContentView: View {
//    var body: some View {
//        // Your main content view goes here
//        Text("Hello, World!")
//    }
//}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

private struct CurrentThemeKey: EnvironmentKey {
  static let defaultValue = defaultTheme
}

private struct ContentWidthKey: EnvironmentKey {
  static let defaultValue = UIScreen.screenWidth
}

extension EnvironmentValues {
  var contentWidth: Double {
    get { self[ContentWidthKey.self] }
    set { self[ContentWidthKey.self] = newValue }
  }
  var useTheme: WinstonTheme {
    get { self[CurrentThemeKey.self] }
    set { self[CurrentThemeKey.self] = newValue }
  }
}


