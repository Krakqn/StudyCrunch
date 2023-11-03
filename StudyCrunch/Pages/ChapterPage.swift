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
  var chapter: Chapter
  
  var body: some View {
    ScrollView {
      HStack {
        Markdown(chapter.markdown)
        .markdownTheme(.docC)
        Spacer()
      }
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
        ShareLink(item: appUrl) {
          Label("Share", systemImage: "square.and.arrow.up")
            .font(.system(size: 20).bold())
            .foregroundColor(Color("ForegroundColor"))
        }.simultaneousGesture(TapGesture().onEnded() {
          withAnimation(.easeIn(duration: 0.3).delay(0.3)) {
            self.t = 0.0
          }
        })
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
    .navigationTitle(chapter.name)
  }
}

#Preview {
  ChapterPage(chapter: Chapter(symbol: "!", name: "Chapter Testing", description: "Dummy chapter for testing!", markdown: """
# Chapter Testing
- Hello World!
"""))
}
