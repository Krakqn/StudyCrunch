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
import AlertToast

struct ChapterPage: View {

  let chapter: Chapter
  let section: Section

  @State private var flashcards: [Flashcard] = []
  @State private var resultMail: MFMailComposeResult = .failed
  @State private var resultMessage: MessageComposeResult = .failed

  @EnvironmentObject var viewModel: ViewModel
  @EnvironmentObject var storeKit: StoreKitManager

  @State private var numberOfCardDisplayed = 0
  @State private var flashcardOverlayOpacity: CGFloat = 0.0
  @State private var shareOverlayOpacity: CGFloat = 0.0

  func removeTopFlashcard() {
    var newFlashcards = flashcards
    if newFlashcards.count > 0 {
      numberOfCardDisplayed += 1
      if numberOfCardDisplayed > 0 && numberOfCardDisplayed % flashcards.count == 0 {
        viewModel.newRound = true
      } else {
        viewModel.newRound = false
      }
      newFlashcards.append(newFlashcards.removeFirst())
    }
    withAnimation(.bouncy) {
      flashcards = newFlashcards
    }
    viewModel.isFlashcardFront = true
  }

  var body: some View {
    ZStack {
      ScrollView {
        VStack(spacing: 24) {
          if let pdf = chapter.pdfData {
            PDFKitRepresentedView(pdf, singlePage: false)
              .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.414)
          } else {
            HStack {
              Markdown(chapter.markdown)
                .markdownTheme(.docC)
              Spacer()
            }
          }

          if flashcards.count > 0 {
            ZStack {
              ForEach(Array(flashcards.suffix(4).enumerated()), id: \.element) { i, flashcard in
                FlashcardView(flashcard: flashcard, index: i, takeItselfOut: removeTopFlashcard)
              }
              VStack {
                HStack {
                  Spacer()
                  Button {
                    // open large flashcard
                    viewModel.isShowingFullscreenOverlay.toggle()
                    guard let flashcard = flashcards.suffix(4).first else { return }
                    if viewModel.isShowingFullscreenOverlay {
                      viewModel.flashcardOverlayContent = flashcard.back
                    } else {
                      viewModel.flashcardOverlayContent = ""
                    }
                  } label: {
                    Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                      .tint(.white)
                  }
                }
                Spacer()
              }
              .opacity(viewModel.isFlashcardFront ? 0 : 1)
            }
            .padding(.bottom, 50)
          }
        }
      }
      .onAppear {
        flashcards = chapter.flashcards
      }
      .padding()
      .blur(radius: viewModel.blurOpacity * 12.0)
      .overlay {
        ZStack {
          VStack(spacing: 10) {
            Image(systemName: chapter.restricted ? "lock.fill" : "lock.open.fill")
              .font(.system(size: 64))
              .contentTransition(.symbolEffect(.replace))
              .padding(.top, 100)
            Text(chapter.restricted ? "Chapter locked!" : "Section unlocked!")
              .font(.system(size: 32))
            Text(chapter.restricted ? "Choose a method below to unlock it" : "")
              .frame(height: 32)

            Spacer()

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
        .opacity(shareOverlayOpacity)

        // large flashcard overlay
        ZStack(alignment: .topTrailing) {
          ScrollView {
            VStack {
              Text(viewModel.flashcardOverlayContent)
                .font(Font.system(size: 24, weight: .semibold, design: .serif))
                .padding()
            }
          }
          .padding(.vertical)

          Button {
            closeLargeFlashcard()
          } label: {
            Image(systemName: "xmark")
              .tint(.white)
              .padding()
          }
        }
        .background(.card)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding([.top, .bottom], 100)
        .padding(.horizontal)
        .opacity(flashcardOverlayOpacity)
        .onChange(of: viewModel.flashcardOverlayContent) {
          if !viewModel.flashcardOverlayContent.isEmpty {
            withAnimation {
              viewModel.blurOpacity = 1.0
              flashcardOverlayOpacity = 1.0
            }
          }
        }
      }
    }
    .navigationTitle(chapter.name)
    .sheet(isPresented: $viewModel.isShowingMailView) {
      MailView(message: "initial message", isShowing: $viewModel.isShowingMailView, result: self.$resultMail)
        .onDisappear {
          if self.resultMail != .sent {
            viewModel.showToast.toggle()
          }
        }
    }
    .sheet(isPresented: $viewModel.isShowingMessageView) {
      MessageView(message: "initial message", isShowing: $viewModel.isShowingMessageView, result: self.$resultMessage)
        .onDisappear {
          if self.resultMessage != .sent {
            viewModel.showToast.toggle()
          }
        }
    }
    .onAppear {
      if self.chapter.restricted {
        withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
          viewModel.blurOpacity = 1.0
          shareOverlayOpacity = 1.0
        }
      }
    }
    .onDisappear {
      viewModel.blurOpacity = 0.0
      viewModel.isFlashcardFront = true
    }
    .onChange(of: viewModel.shareModalOpen, {
      if !self.chapter.restricted {
        withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
          viewModel.blurOpacity = 0.0
          shareOverlayOpacity = 0.0
        }
      }
    })
    .onChange(of: resultMail) { oldValue, newValue in
      let success = resultMail == .sent || resultMessage == .sent
      if success {
        Global.unlockSection(section)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          viewModel.shareModalOpen = !success
        }
      }
    }
    .onChange(of: resultMessage) { oldValue, newValue in
      let success = resultMail == .sent || resultMessage == .sent
      if success {
        Global.unlockSection(section)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          viewModel.shareModalOpen = !success
        }
      }
    }
    .onChange(of: storeKit.purchasedCourses) { oldValue, newValue in
      if !self.chapter.restricted {
        withAnimation(.easeIn(duration: 0.3).delay(0.5)) {
          viewModel.blurOpacity = 0.0
          shareOverlayOpacity = 0.0
        }
        viewModel.showPaymentSuccess.toggle()
      }
    }

  }

  private func closeLargeFlashcard() {
    withAnimation(.easeInOut(duration: 0.3)) {
      viewModel.blurOpacity = 0.0
      flashcardOverlayOpacity = 0.0
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
      viewModel.isShowingFullscreenOverlay = false
      viewModel.flashcardOverlayContent = ""
    }

  }
}


//#Preview {
//  ChapterPage(chapter: Chapter(symbol: "!", name: "Chapter Testing", description: "Dummy chapter for testing!", markdown: """
//# Chapter Testing
//- Hello World!
//""", restricted: true))
//}
