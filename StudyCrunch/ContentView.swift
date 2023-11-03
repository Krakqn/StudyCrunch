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
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
        Course(emoji: "💻", name: "Computer Science", shortDescription: "The best subject!", longDescription: "The science of computers...", chapters: [
          Chapter(number: 1, name: "Variables", access: true), //passing in access to test
          Chapter(number: 2, name: "Loops", access: false),
          Chapter(number: 3, name: "Conditionals", access: false)
        ]),
        Course(emoji: "📕", name: "English", shortDescription: "The worst subject.", longDescription: "Waste of time.", chapters: [
          Chapter(number: 1, name: "Waste of time 1", access: false),
          Chapter(number: 2, name: "Waste of time 2", access: true),
          Chapter(number: 3, name: "Appendix: Waste of time", access: false)
        ]),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: []),
        Course(emoji: "⁉️", name: "Filler", shortDescription: "Nothing in particular...", longDescription: "Nothing in particular...", chapters: [])
=======
>>>>>>> 8d63a139293ab1b05d592af276239aa569f02cb8
        try! Course.Builder()
          .setEmoji(emoji: "💻")
          .setName(name: "Computer Science")
          .setDescription(description: "The best subject!")
          .setChapterBuilders(chapterBuilders: [
            Chapter.Builder()
              .setName(name: "Variables")
              .setDescription(description: "Super useful")
              .setMarkdown(markdown: """
# Variables
Here's an example of a variable being used:
```cpp
#include <iostream>

int main(void) {
  int x = 10;
  std::cout << "Value of variable x: " << x << std::endl;
}
```
"""),
            Chapter.Builder()
              .setName(name: "Loops")
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Conditionals")
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Arrays")
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Pointers")
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Complexity")
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdown: ""),
          ])
          .build()
<<<<<<< HEAD
=======
>>>>>>> Stashed changes
>>>>>>> 8d63a139293ab1b05d592af276239aa569f02cb8
      ])
      .tabItem {
        Label("Courses", systemImage: "book.closed")
      }
      SettingsPage()
        .tabItem {
          Label("Settings", systemImage: "gearshape")
        }
    }
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
        // This block will be executed when the app is about to move to the background
        UIPasteboard.general.string = ""
    } //Clears the clipboard so you can't just copy locked notes in the background
  } //Source: https://blog.eidinger.info/prevent-copy-paste-into-other-ios-apps
  
  struct NavbarButton {
    
=======
>>>>>>> Stashed changes
>>>>>>> 8d63a139293ab1b05d592af276239aa569f02cb8
  }
}

#Preview {
  ContentView()
    .environment(\.colorScheme, .dark)
}
