//
//  ChapterMenu.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI

struct ChapterMenu: View {
  var course: Course
  
  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(course.chapters) { chapter in
          NavigationLink {
            ChapterView(chapter: chapter)
          } label: {
            MenuOption(emoji: "\(chapter.number)", name: chapter.name, access: chapter.access)
              .padding(.horizontal) //above greys out the menu button if user has no access
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle(course.name)
    }
  }
}
