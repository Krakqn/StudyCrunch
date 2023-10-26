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
  
  var body: some Scene { //added the preview part here for ability to test cohesive app as a whole
    WindowGroup {
      //ContentView() //comment for merge
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
      ])
        .sheet(isPresented: $credModalOpen) {
          Onboarding(open: $credModalOpen)
        }
    }
  }
}
