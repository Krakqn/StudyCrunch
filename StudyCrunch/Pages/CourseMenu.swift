//
//  CourseSelect.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI
import Defaults
import Pow

struct CourseMenu: View {
  @State private var searchText = ""
  @State private var isPressed: [UUID: Bool] = [:]
  var courses: [Course]
  @Default(.showOnboarding) private var showOnboarding
  
  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(searchResults) { course in
          let coursePressedState = Binding(
              get: { isPressed[course.id, default: false] },
              set: { isPressed[course.id] = $0 }
          )
          NavigationLink {
            SectionMenu(course: course)
          } label: {
            MenuOption(symbol: course.emoji, name: course.name, description: course.shortDescription)
              .padding(.horizontal)
          }
          ._onButtonGesture {
              coursePressedState.wrappedValue = $0
          } perform: {

          }
          .conditionalEffect(.pushDown, condition: coursePressedState.wrappedValue)
          .onAppear {
              isPressed[course.id] = false
          }
        }
        Button("Show onboarding") {
          showOnboarding = true
        }.padding(.top, 16)
      }
      .searchable(text: $searchText)
      .navigationTitle("Courses")
    }
  }
  
  var searchResults: [Course] {
    if searchText.isEmpty {
      return courses
    } else {
      return courses.filter { $0.name.starts(with: searchText) }
    }
  }
}
