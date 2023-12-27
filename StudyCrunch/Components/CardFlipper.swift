//
//  CardFlipper.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 23/11/23.
//

import SwiftUI

struct CardFlipper<Content: View>: View {
  @State private var backDegree = 0.0
  @State private var frontDegree = -89.9
  @State private var showFront = false
  @State private var showBack = true
  @State private var isFlipped = false
  
  let width : CGFloat = 200
  let height : CGFloat = 250
  let animation : Animation = .snappy
  
  @ViewBuilder var front: Content
  @ViewBuilder var back: Content
  
  func flipCard () {
    isFlipped = !isFlipped
    if isFlipped {
      withAnimation(.easeIn.speed(1.5)) {
        backDegree = 89.9
      } completion: {
        showBack = false
        showFront = true
        withAnimation(.easeOut.speed(1.5)) {
          frontDegree = 0
        }
      }
    } else {
      withAnimation(.easeIn.speed(1.5)) {
        frontDegree = -89.9
      } completion: {
        showBack = true
        showFront = false
        withAnimation(.easeOut.speed(1.5)) {
          backDegree = 0
        }
      }
    }
  }
  
  var body: some View {
    ZStack {
      let cardSize = UIScreen.main.bounds.width * 0.75
      if showFront {
        ScrollView(.vertical) {
          front
            .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
        }
        .frame(height: cardSize * 0.75)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      }
      if showBack {
        ScrollView(.vertical) {
          back
            .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
        }
        .frame(height: cardSize * 0.75)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      }
    }.highPriorityGesture(TapGesture().onEnded {
      flipCard()
    })
  }
}
