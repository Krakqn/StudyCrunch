//
//  ChapterMenu.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/26/23.
//

import Foundation
import SwiftUI

struct ChapterMenu: View {
  var section: Section
  
  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(section.chapters) { chapter in
          NavigationLink {
            ChapterPage(chapter: chapter, section: section)
          } label: {
            let accessoryIcon = chapter.restricted ? "lock" : nil
            MenuOption(symbol: chapter.symbol, name: chapter.name, description: chapter.description, accessoryIcon: accessoryIcon)
              .padding(.horizontal)
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Chapters")
    }
  }
}
