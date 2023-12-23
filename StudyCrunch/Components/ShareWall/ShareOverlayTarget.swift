//
//  ShareOverlayTarget.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI
import Defaults
import Pow

func movePoint(point1: CGPoint, toward point2: CGPoint, when distanceLessThan: CGFloat) -> CGSize {
    let distance = hypot(point2.x - point1.x, point2.y - point1.y)
    
    guard distance < distanceLessThan else { return CGSize.zero }
    
    let t = 1 - (distance / distanceLessThan)
    let interpolationFactor = t * t
    let deltaX = interpolationFactor * (point2.x - point1.x)
    let deltaY = interpolationFactor * (point2.y - point1.y)
    return CGSize(width: deltaX, height: deltaY)
}

struct ShareOverlayTarget: View, Equatable {
  static let size: Double = 56
  static let strokeWidth: Double = 3
  static let fontSize: Double = 12
  static let vStackSpacing: Double = 4
  static let hitboxTolerance: Double = 5
  
  static func == (lhs: ShareOverlayTarget, rhs: ShareOverlayTarget) -> Bool {
    lhs.index == rhs.index && lhs.hovered == rhs.hovered && lhs.distance == rhs.distance && lhs.attraction == rhs.attraction
  }

  @State private var jump = 0
  @State private var impactRigid = UIImpactFeedbackGenerator(style: .rigid)

  let title: String
  let systemImageName: String
  let color: Color
  let containerSize: CGSize
  let index: Int
  let targetsCount: Int
  
  @ObservedObject var transmitter: ShareOverlayTransmitter
  
  private var appear: Bool { transmitter.showing }
  private var fingerPos: CGPoint { transmitter.positionInfo?.location ?? .zero }
  private var globalCirclePos: CGPoint { transmitter.positionInfo?.initialLocation ?? .zero }

  private let distanceMaxSelectedVibrating: Double = 100
  private let verticalOffset = -50.0
  private let textSpace = (ShareOverlayTarget.fontSize * 1.2) + ShareOverlayTarget.vStackSpacing
  private var isSelected: Bool { false }//!isAddBtn && Defaults[.GeneralDefSettings].redditCredentialSelectedID == cred.id }
  private var radiusX: Double { (containerSize.width / 2) }
  private var radiusY: Double { (containerSize.height / 2) }
  private var initialOffset: CGSize { getOffsetAroundCircleForIndex(count: targetsCount, index: index, circleSize: containerSize) }
  private var x: Double { initialOffset.width }
  private var y: Double { -initialOffset.height }
  private var xMin: Double { globalCirclePos.x - (ShareOverlayTarget.size / 2) + x + radiusX }
  private var xMax: Double { xMin + ShareOverlayTarget.size }
  private var yMin: Double { globalCirclePos.y - (ShareOverlayTarget.size / 2) + verticalOffset + y }
  private var yMax: Double { yMin + ShareOverlayTarget.size }
  private var attraction: CGSize {
    let targetPos = CGPoint(x: (xMin + xMax) / 2, y: (yMin + yMax) / 2)
    return movePoint(point1: targetPos, toward: fingerPos, when: 100)
  }
  private var distance: Double {
    return max( ShareOverlayTarget.size / 2, min(distanceMaxSelectedVibrating, abs(CGPoint(x: (xMin + xMax) / 2, y: (yMin + yMax) / 2).distanceTo(point: fingerPos))))
  }
  private var hovered: Bool {
    let actualAttraction: CGSize = isSelected ? .zero : attraction
    let xRange = (xMin + actualAttraction.width - Self.hitboxTolerance)...(xMax + actualAttraction.width + Self.hitboxTolerance)
    let yRange = (yMin + actualAttraction.height - Self.hitboxTolerance)...(yMax + actualAttraction.height + Self.hitboxTolerance)
    return xRange.contains(fingerPos.x) && yRange.contains(fingerPos.y)
  }
  
  var body: some View {
    let interpolateVibration = interpolatorBuilder([0, distanceMaxSelectedVibrating], value: distance)
    let attractionOffset: CGSize = (isSelected ? .zero : attraction)
    let appearingOffset = CGSize(width: appear ? x + radiusX : 0, height: appear ? y + verticalOffset : 0)

    Group {
      ZStack {
        Color.white
        Circle()
          .foregroundStyle(color)
          .padding(2)
        Image(systemName: systemImageName)
          .fontSize(24)
          .foregroundStyle(.primary)
      }
    }
    .frame(Self.size - (Self.strokeWidth * 2))
    .mask(Circle().fill(.black))
    .background(
      isSelected || (!hovered)
      ? nil
      : Image(.spotlight)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(150)
    )
    .frame(Self.size)
    .changeEffect(.shake(rate: .fast), value: jump)
    .background(alignment: .top) {
      VStack(spacing: 2) {
        Text(title)
          .fixedSize(horizontal: true, vertical: false)
          .foregroundStyle(.primary)
          .fontSize(Self.fontSize, .semibold)
      }
      .frame(alignment: .top)
      .position(x: Self.size / 2, y: Self.size + Self.vStackSpacing + ((Self.fontSize * 1.2) / 2))
      .scaleEffect(1)
    }
    .saturation(isSelected ? 0.5 : 1)
    .compositingGroup()
    .shadow(color: .black.opacity(isSelected ? 0 : 0.35), radius: 13, x: 0, y: 8)
    .floatingBounceEffect(disabled: isSelected || !appear || hovered)
    .scaleEffect(appear ? !isSelected && hovered ? 1.25 : 1 : 0.1)
    .blur(radius: appear ? 0 : 30)
    .brightness(!isSelected && hovered ? 0.5 : 0)
    .offset(attractionOffset + appearingOffset)
    .animation(hovered ? .snappy(duration: 0.15, extraBounce: 0.35) : .spring, value: hovered)
    .animation(.bouncy, value: attraction)
    .opacity(appear ? 1 : 0)
    .animation(appear ? .bouncy.delay(0.05 * Double((targetsCount - 1) - index)) : .snappy.delay(0.025 * Double(index)), value: appear)
    .vibrate(.continuous(sharpness: hovered ? 0 : interpolateVibration([0.3, 0], false), intensity: hovered ? 0 : interpolateVibration([0.3, 0], false)), trigger: isSelected && !hovered ? distance : 0, disabled: !appear)
    .vibrate(.transient(sharpness: !isSelected && !hovered ? 1.0 : 0, intensity: isSelected && hovered ? 0 : 1.0), trigger: hovered, disabled: !appear)
    .onChange(of: hovered) {
      if transmitter.selectedCred == nil && $0 { transmitter.selectedCred = title }
      else if transmitter.selectedCred == title && !$0 { transmitter.selectedCred = nil }
    }
    .onChange(of: hovered) { if $0 && isSelected { jump += 1 } }
    .transition(.identity)
  }
}
