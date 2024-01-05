//
//  ChapterMenu.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI
import Pow

struct SectionMenu: View {
  var course: Course
  @State private var isPressed: [UUID: Bool] = [:]
  
  var body: some View {
    NavigationStack {
      ScrollView {
        ForEach(course.sections) { section in
          let sectionPressedState = Binding(
            get: { isPressed[section.id, default: false] },
            set: { isPressed[section.id] = $0 }
          )
          
          NavigationLink {
            ChapterMenu(section: section)
          } label: {
            MenuOption(symbol: section.symbol, name: section.name, description: section.description)
              .padding(.horizontal)
          }
          ._onButtonGesture {
            sectionPressedState.wrappedValue = $0
          } perform: {
            
          }
          .conditionalEffect(.pushDown, condition: sectionPressedState.wrappedValue)
          .onAppear {
            isPressed[section.id] = false
          }
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Sections")
    }
  }
}

