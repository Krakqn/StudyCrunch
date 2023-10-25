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
            ChapterMenu(chapters: course.chapters)
          } label: {
            CourseMenuOption(course: course)
              .padding(.horizontal)
          }
        }
        .navigationTitle("Courses")
      }
    }
    .searchable(text: $searchText)
  }
  
  var searchResults: [Course] {
    if searchText.isEmpty {
      return courses
    } else {
      return courses.filter { $0.name.starts(with: searchText) }
    }
  }
  
  struct CourseMenuOption: View {
    var course: Course
    
    var body: some View {
      HStack(spacing: 15) {
        Text(course.emoji)
          .fontSize(30)
          .frame(width: 40)
        VStack(alignment: .leading, spacing: 3) {
          Text(course.name)
            .fontSize(20, .bold)
          Text(course.shortDescription)
            .fontSize(15)
            .opacity(0.8)
        }
      }
      .padding()
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
      .background(.black)
      .foregroundColor(.white)
      .cornerRadius(10)
    }
  }
}

#Preview {
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
}
