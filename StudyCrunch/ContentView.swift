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
        try! Course.Builder()
          .setEmoji(emoji: "💻")
          .setName(name: "Computer Science")
          .setDescription(description: "The best subject!")
          .setChapterBuilders(chapterBuilders: [
            Chapter.Builder()
              .setName(name: "Variables")
              .setDescription(description: "Super useful")
              .setFlashcards(jsonFileName: "computer-science")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Loops")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Conditionals")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Arrays")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Pointers")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Complexity")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Complexity")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdownFilename: "sample"),
          ])
          .build(),

        try! Course.Builder()
          .setEmoji(emoji: "📕")
          .setName(name: "English")
          .setDescription(description: "The worst subject!")
          .setChapterBuilders(chapterBuilders: [
            Chapter.Builder()
              .setName(name: "Variables")
              .setDescription(description: "Super useful")
              .setFlashcards(jsonFileName: "computer-science")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Loops")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Conditionals")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Arrays")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Pointers")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Complexity")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Complexity")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdownFilename: "sample"),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdownFilename: "sample"),
          ])
          .build()
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
