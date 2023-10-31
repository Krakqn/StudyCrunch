//
//  ChapterView.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI

struct ChapterView: View {
  var chapter: Chapter
  @State private var spoiler: Bool
  
  init(chapter: Chapter) {
      self.chapter = chapter
      self._spoiler = State(initialValue: !chapter.access) //spoiler is true if you don't have access
  }
  
  var body: some View {
    VStack {
      VStack {
        Text("If you need a more persistent indication, you can double-click either the opening or the closing delmiter, and Xcode will select both delimiters and their contents. (You can also use this, for example, to get quickly to one delimiter from another, even if they're far apart — double-click the delimiter you can see, use the left or right arrow to get the the other end of the selection.")
      }
      .contentShape(Rectangle())
      .compositingGroup()
      .opacity(spoiler ? 0.55 : 1)
      .blur(radius: spoiler ? 12 : 0)
      .overlay(
        !spoiler
        ? nil
        : VStack {
          Text("It's a long text, we won't spam you with that without your consent.")
            .opacity(0.75)
            .fontSize(14)
          Text("Tap to read")
            .fontSize(16, .medium)
          Image(systemName: "hand.tap.fill")
        }
          .padding(.top, 72)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
          .contentShape(Rectangle())
          .onTapGesture {
            withAnimation {
              spoiler = false
            }
          }
      )
    }
  }
}
