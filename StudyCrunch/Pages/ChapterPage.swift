//
//  ChapterView.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI
import MarkdownUI
import MessageUI

struct ChapterPage: View {

  let chapter: Chapter
  let section: Section

  @State private var t: CGFloat = 0.0
  @State private var flashcards: [Flashcard] = []
  @State private var resultMail: MFMailComposeResult = .failed
  @State private var resultMessage: MessageComposeResult = .failed
  @State private var isShowingSuccessMessage: Bool = false

  @EnvironmentObject var viewModel: ViewModel
  @EnvironmentObject var storeKit: StoreKitManager

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
    ZStack {
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
        ZStack {
          VStack(spacing: 10) {
            Text("Donate once to unlock everything")
              .opacity(75)
              .font(.system(size: 20))
              .padding(.horizontal, 20)
              .multilineTextAlignment(.center)

            Button {
              Task {
                guard let product = storeKit.storeProducts.first else { return }
                try await storeKit.purchase(product)
              }
            } label: {
              Label("Donate", systemImage: "arrow.up.heart")
                .font(.system(size: 20).bold())
                .foregroundColor(Color("ForegroundColor"))
            }
          }

          VStack(spacing: 10) {
            Spacer()
            Text("Hold share to unlock the section")
              .opacity(75)
              .font(.system(size: 20))
              .padding(.horizontal, 20)
              .multilineTextAlignment(.center)

            Label("Share", systemImage: "square.and.arrow.up")
              .font(.system(size: 20).bold())
              .foregroundColor(Color("ForegroundColor"))
              .padding(.bottom, 60)
          }

          ShareWall()
        }
        .opacity(self.t)
      }

      if isShowingSuccessMessage {
        Text("Section Unlocked")
          .padding()
          .background(.green)
          .foregroundStyle(.white)
          .clipShape(RoundedRectangle(cornerRadius: 16))
      }
    }
    .navigationTitle(chapter.name)
    .sheet(isPresented: $viewModel.isShowingMailView) {
      MailView(isShowing: $viewModel.isShowingMailView, result: self.$resultMail)
    }
    .sheet(isPresented: $viewModel.isShowingMessageView) {
      MessageView(isShowing: $viewModel.isShowingMessageView, result: self.$resultMessage)
    }
    .onAppear {
      if self.chapter.restricted {
        withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
          self.t = 1.0
        }
      }
    }
    .onChange(of: viewModel.shareModalOpen, {
      if !self.chapter.restricted {
        withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
          self.t = 0.0
        }
      }
    })
    .onChange(of: resultMail) { oldValue, newValue in
      let success = resultMail == .sent || resultMessage == .sent
      if success {
        Global.unlockSection(section)
        viewModel.shareModalOpen = !success
        showSuccessMessage()
      }
    }
    .onChange(of: resultMessage) { oldValue, newValue in
      let success = resultMail == .sent || resultMessage == .sent
      if success {
        Global.unlockSection(section)
        viewModel.shareModalOpen = !success
        showSuccessMessage()
      }
    }
    .onChange(of: storeKit.purchasedCourses) { oldValue, newValue in
      if !self.chapter.restricted {
        withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
          self.t = 0.0
        }
      }
    }
  }

  private func showSuccessMessage() {
    withAnimation {
      isShowingSuccessMessage.toggle()
    }

    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
      withAnimation {
        isShowingSuccessMessage.toggle()
        timer.invalidate()
      }
    }
  }
}


//#Preview {
//  ChapterPage(chapter: Chapter(symbol: "!", name: "Chapter Testing", description: "Dummy chapter for testing!", markdown: """
//# Chapter Testing
//- Hello World!
//""", restricted: true))
//}
