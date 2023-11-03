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
        try! Course.Builder()
          .setEmoji(emoji: "💻")
          .setName(name: "Computer Science")
          .setDescription(description: "The best subject!")
          .setChapterBuilders(chapterBuilders: [
            Chapter.Builder()
              .setName(name: "Variables")
              .setDescription(description: "Super useful")
              .setRestricted(restricted: true)
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
              .setRestricted(restricted: true)
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Arrays")
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Pointers")
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Complexity")
              .setRestricted(restricted: true)
              .setMarkdown(markdown: ""),
            Chapter.Builder()
              .setName(name: "Depth-first search")
              .setMarkdown(markdown: ""),
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
  }
}

#Preview {
  ContentView()
    .environment(\.colorScheme, .dark)
}
