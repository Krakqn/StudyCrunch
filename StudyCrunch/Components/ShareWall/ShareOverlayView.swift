//
//  AccountSwitcherView.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 25/11/23.
//

import SwiftUI

struct ShareOverlayView: View, Equatable {
  static func == (lhs: ShareOverlayView, rhs: ShareOverlayView) -> Bool {
    lhs.fingerPosition == rhs.fingerPosition && lhs.appear == rhs.appear
  }
  
  let fingerPosition: ShareOverlayTransmitter.PositionInfo
  let appear: Bool
  @ObservedObject var transmitter: ShareOverlayTransmitter

  @State private var showOverlay = false
  
  private let targetsContainerSize: CGSize = .init(width: 250, height: 150)

  var body: some View {
    let lastsUntilEndOfAllTransitions = transmitter.positionInfo != nil || appear
    ZStack(alignment: .bottom) {
      ShareOverlayGradientBackground().equatable().opacity(lastsUntilEndOfAllTransitions ? 1 : 0).animation(.easeIn, value: appear)
      
      ZStack {
        ShareOverlayTarget(title: "Share with email", systemImageName: "envelope.fill", color: .blue, containerSize: targetsContainerSize, index: 0, targetsCount: 2, transmitter: transmitter)

        ShareOverlayTarget(title: "Share with iMessage", systemImageName: "message.fill", color: .green, containerSize: targetsContainerSize, index: 1, targetsCount: 2, transmitter: transmitter)
      }
      .frame(targetsContainerSize)
      .position(fingerPosition.initialLocation)
      .drawingGroup()

      ShareOverlayFingerLight().equatable().position(fingerPosition.location).opacity(!appear ? 0 : 1).animation(.easeOut, value: appear).drawingGroup()
      
      ShareOverlayParticles().equatable().opacity(lastsUntilEndOfAllTransitions ? 1 : 0).animation(.easeIn, value: appear)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .multilineTextAlignment(.center)
    .ignoresSafeArea(.all)
    .allowsHitTesting(false)
  }
}
