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
<<<<<<< Updated upstream:StudyCrunch/ChapterMenu.swift
            MenuOption(emoji: "\(chapter.number)", name: chapter.name, access: chapter.access)
              .padding(.horizontal) //above greys out the menu button if user has no access
=======
            MenuOption(symbol: section.symbol, name: section.name, description: section.description)
>>>>>>> Stashed changes:StudyCrunch/Pages/SectionMenu.swift
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Sections")
    }
  }
}
