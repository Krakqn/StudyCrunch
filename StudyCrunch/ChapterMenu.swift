//
//  ChapterMenu.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI

struct ChapterMenu: View {
  var chapters: [Chapter]
  
  var body: some View {
    List(chapters) { chapter in
      NavigationLink {
        ChapterView(chapter: chapter)
      } label: {
        ChapterMenuOption(chapter: chapter)
      }
    }
  }
  
  struct ChapterMenuOption: View {
    var chapter: Chapter
    
    var body: some View {
      HStack {
        Text("\(chapter.number)")
        Text(chapter.name)
      }
    }
  }
}
