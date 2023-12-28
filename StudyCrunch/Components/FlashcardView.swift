//
//  FlashcardView.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 23/11/23.
//

import SwiftUI

extension View {
  func cardFace(_ size: Double) -> some View {
    self
      .padding(.horizontal, 24)
      .padding(.vertical, 10)
      .frame(width: size)
      .frame(minHeight: size * 0.75)
      .multilineTextAlignment(.center)
  }
}

struct FlashcardView: View {
  var flashcard: Flashcard
  var index: Int
  var takeItselfOut: () -> ()
    var body: some View {
      let cardSize = UIScreen.main.bounds.width * 0.75
      CardFlipper {
        Text(flashcard.back)
          .font(Font.system(size: 24, weight: .semibold, design: .serif))
          .cardFace(cardSize)
      } back: {
        Text(flashcard.front)
          .font(Font.system(size: 32, weight: .bold, design: .serif))
          .cardFace(cardSize)
      }
      .draggableCardFromPile(index: index, threshold: 100, takeItselfOut: takeItselfOut)
    }
}
