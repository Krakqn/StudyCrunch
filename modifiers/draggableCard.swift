//
//  draggableCard.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 23/11/23.
//
import Foundation
import SwiftUI

struct DraggableCard: ViewModifier {
  var index: Int
  var takeItselfOut: () -> ()
  var threshold: Double = 100
  @State private var endSide: PreviewSideCard = .none
  @State private var offset: CGSize = .zero
  @State private var offsetCompensation: CGSize? = nil
  @State private var pressing = false
  
  enum PreviewSideCard {
    case left
    case right
    case none
  }

  func body(content: Content) -> some View {
    let screenWidth = UIScreen.main.bounds.size.width
    let interpolatedX = interpolatorBuilder([-screenWidth, screenWidth], value: offset.width)
    content
    .rotationEffect(Angle(degrees: interpolatedX([-35,35], true)))
    .offset(offset)
    .highPriorityGesture(
      index != 0
      ? nil
      : DragGesture(minimumDistance: 5)
        .onChanged { val in
          if offsetCompensation == nil {
            offsetCompensation = val.translation
          } else if let offsetCompensation = offsetCompensation {
            var transaction = Transaction()
            transaction.isContinuous = true
            transaction.animation = .interpolatingSpring(stiffness: 1000, damping: 100)
            
            withTransaction(transaction) {
              endSide = abs(val.translation.width) < threshold ? .none : val.translation.width > 0 ? .right : .left
              offset = val.translation - offsetCompensation
            }
          }
        }
        .onEnded { val in
          let offscreenX = UIScreen.main.bounds.size.width
          withAnimation(.interpolatingSpring(stiffness: 150, damping: 17, initialVelocity: 0)) {
            offset = endSide == .left ? CGSize(width: -offscreenX, height: val.translation.height * 1.25) : endSide == .right ? CGSize(width: offscreenX, height: val.translation.height * 1.25) : .zero
            pressing = false
            offsetCompensation = nil
          }
          if endSide != .none {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
              takeItselfOut()
            }
          }
        }
    )
    .scaleEffect(1 - (Double(index) * 0.05))
    .brightness(0 - (Double(index) * 0.05))
    .offset(y: Double(index) * 22)
    .zIndex(-Double(index))
    .allowsHitTesting(index == 0)
  }
}

extension View {
  func draggableCardFromPile(index: Int, threshold: Double, takeItselfOut: @escaping () -> ()) -> some View {
    self.modifier(DraggableCard(index: index, takeItselfOut: takeItselfOut, threshold: threshold))
    }
}

func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}
func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}
