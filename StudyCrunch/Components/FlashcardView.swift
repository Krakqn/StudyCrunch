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
      .frame(width: size)
      .frame(minHeight: size * 0.75)
      .multilineTextAlignment(.center)
      .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color("CardColor")))
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
