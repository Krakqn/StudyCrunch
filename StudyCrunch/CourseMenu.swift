//
//  CourseSelect.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI

struct CourseSelectOption: View {
  var course: Course
  
  var body: some View {
    HStack {
      Text(course.emoji)
      VStack {
        Text(course.name)
        Text(course.shortDescription)
      }
    }
  }
}

struct CourseSelectMenu: View {
  var courses: [Course]
  
  var body: some View {
    List(courses) { course in
      CourseSelectOption(course: course)
    }
  }
}

#Preview {
  CourseSelectMenu(courses: [
    Course(id: 0, emoji: "C", name: "Computer Science", shortDescription: "the best subject", longDescription: "the best subject :)")
  ])
}
