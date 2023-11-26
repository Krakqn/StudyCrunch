//
//  CourseSelect.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI
import Defaults

struct CourseMenu: View {
  @State private var searchText = ""
  var courses: [Course]
  @Default(.showOnboarding) private var showOnboarding
  
  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(searchResults) { course in
          NavigationLink {
            SectionMenu(course: course)
          } label: {
            MenuOption(symbol: course.emoji, name: course.name, description: course.shortDescription)
              .padding(.horizontal)
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
