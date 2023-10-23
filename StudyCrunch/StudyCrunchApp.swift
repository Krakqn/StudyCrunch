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


