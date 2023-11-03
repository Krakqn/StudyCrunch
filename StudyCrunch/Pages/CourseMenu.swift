//
//  CourseSelect.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI

struct CourseMenu: View {
  @State private var searchText = ""
  var courses: [Course]
  
  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(searchResults) { course in
          NavigationLink {
            SectionMenu(course: course)
          } label: {
<<<<<<< HEAD
            MenuOption(symbol: course.emoji, name: course.name, description: course.shortDescription)
=======
<<<<<<< Updated upstream:StudyCrunch/CourseMenu.swift
            MenuOption(emoji: course.emoji, name: course.name, description: course.shortDescription, access: true) //since you can access all courses at all time just pass in true
=======
            MenuOption(symbol: course.emoji, name: course.name, description: course.shortDescription)
>>>>>>> Stashed changes:StudyCrunch/Pages/CourseMenu.swift
>>>>>>> 8d63a139293ab1b05d592af276239aa569f02cb8
              .padding(.horizontal)
          }
        }
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
