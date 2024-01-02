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
    @State private var isPressed: [UUID: Bool] = [:]

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(section.chapters) { chapter in
                    let chapterPressedState = Binding(
                        get: { isPressed[chapter.id, default: false] },
                        set: { isPressed[chapter.id] = $0 }
                    )

                    NavigationLink {
                        ChapterPage(chapter: chapter, section: section)
                    } label: {
                        let accessoryIcon = chapter.restricted ? "lock.fill" : nil
                        MenuOption(symbol: chapter.symbol, name: chapter.name, description: chapter.description, accessoryIcon: accessoryIcon)
                            .padding(.horizontal)
                    }
                    ._onButtonGesture {
                        chapterPressedState.wrappedValue = $0
                    } perform: {

                    }
                    .conditionalEffect(.pushDown, condition: chapterPressedState.wrappedValue)
                    .onAppear {
                        isPressed[chapter.id] = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Chapters")
        }
    }
}
