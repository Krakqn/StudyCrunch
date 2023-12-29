//
//  ContentView.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import SwiftUI
import Defaults

struct ContentView: View {
  @Default(.showOnboarding) private var showOnboarding
  var body: some View {
    TabView {
      CourseMenu(courses: [
        CSCourse().course,
        EnglishCourse().course,
      ])
      .tabItem {
        Label("Courses", systemImage: "book.closed")
      }
      SettingsPage()
        .tabItem {
          Label("Settings", systemImage: "gearshape")
        }
    }
    .sheet(isPresented: $showOnboarding, content: {
      OnboardingView().interactiveDismissDisabled()
    })
  }
}

#Preview {
  ContentView()
    .environment(\.colorScheme, .dark)
}
