//
//  ChapterMenu.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI

struct SectionMenu: View {
  var course: Course
  
  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(course.sections) { section in
          NavigationLink {
            ChapterMenu(section: section)
          } label: {
            MenuOption(symbol: section.symbol, name: section.name, description: section.description)
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Sections")
    }
  }
}
