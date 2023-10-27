//
//  ContentView.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      CourseMenu(courses: [
        Course(emoji: "💻", name: "Computer Science", shortDescription: "The best subject!", longDescription: "The science of computers...", chapters: [
          Chapter(number: 1, name: "Variables"),
          Chapter(number: 2, name: "Loops"),
          Chapter(number: 3, name: "Conditionals")
        ]),
        Course(emoji: "📕", name: "English", shortDescription: "The worst subject.", longDescription: "Waste of time.", chapters: [
          Chapter(number: 1, name: "Waste of time 1"),
          Chapter(number: 2, name: "Waste of time 2"),
          Chapter(number: 3, name: "Appendix: Waste of time")
        ]),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: [])
      ])
      .tabItem {
        Label("Courses", systemImage: "book.closed")
      }
      SettingsPage()
      .tabItem {
        Label("Settings", systemImage: "gearshape")
      }
    }
  }
  
  struct NavbarButton {
    
  }
}

#Preview {
  ContentView()
    .environment(\.colorScheme, .dark)
}
