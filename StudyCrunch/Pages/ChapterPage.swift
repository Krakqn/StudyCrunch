//
//  ChapterView.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI
import MarkdownUI

struct ChapterPage: View {
    @State private var t: CGFloat = 0.0
    @State var shareModalOpen = false
    var chapter: Chapter
    @State private var flashcards: [Flashcard] = []
    
    func removeTopFlashcard() {
        var newFlashcards = flashcards
        if newFlashcards.count > 0 {
            newFlashcards.append(newFlashcards.removeFirst())
        }
        withAnimation(.bouncy) {
            flashcards = newFlashcards
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HStack {
                    Markdown(chapter.markdown)
                        .markdownTheme(.docC)
                    Spacer()
                }
                if flashcards.count > 0 {
                    ZStack {
                        ForEach(Array(flashcards.suffix(4).enumerated()), id: \.element) { i, flashcard in
                            FlashcardView(flashcard: flashcard, index: i, takeItselfOut: removeTopFlashcard)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            flashcards = chapter.flashcards
        }
        .padding()
            .blur(radius: self.t * 12.0)
            .overlay {
              VStack(spacing: 10) {
                Spacer()
                Text("Share to unlock the chapter")
                  .opacity(75)
                  .font(.system(size: 20))
                  .padding(.horizontal, 20)
                  .multilineTextAlignment(.center)
                Button(action: {
                  // Call your function here
                  yourFunction()
        
//                  withAnimation(.easeIn(duration: 0.3).delay(0.3)) {
//                    self.t = 0.0
//                  }
                }) {
                  Label("Share", systemImage: "square.and.arrow.up")
                    .font(.system(size: 20).bold())
                    .foregroundColor(Color("ForegroundColor"))
                }
                .sheet(isPresented: $shareModalOpen) {
                    ShareMenu(open: $shareModalOpen, unlockName: chapter.name)
                  }
                Spacer()
              }
              .opacity(self.t)
            }
            .onAppear {
              if self.chapter.restricted {
                withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
                  self.t = 1.0
                }
              }
            }
            .onChange(of: shareModalOpen, {
                if !self.chapter.restricted {
                    withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
                        self.t = 0.0
                    }
                }
            })
            .navigationTitle(chapter.name)
    }
    
    // Define your function here
    func yourFunction() {
        // Add your code here
        print("Share button tapped")
        shareModalOpen.toggle()
        // Call any other functions or perform actions you need
    }
}


//#Preview {
//  ChapterPage(chapter: Chapter(symbol: "!", name: "Chapter Testing", description: "Dummy chapter for testing!", markdown: """
//# Chapter Testing
//- Hello World!
//""", restricted: true))
//}
