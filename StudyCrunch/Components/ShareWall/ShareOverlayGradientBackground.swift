//
//  ShareOverlayGradientBackground.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 25/11/23.
//

import SpriteKit
import SwiftUI
import UIKit

let startColor = UIColor(hex: "#E9CBFB")
let endColor = UIColor(hex: "#D9A4F9")

let startColorRGB = startColor.rgb
let endColorRGB = endColor.rgb

let opacities: [Double] = [1,1.000,1.000,0.861,0.786,0.701,0.609,0.514,0.419,0.326,0.239,0.161,0.095,0.044,0]
let locations: [Double] = [0,0.083,0.121,0.159,0.197,0.238,0.284,0.335,0.395,0.463,0.542,0.634,0.740,0.861,1]

func gradientColor(start: (CGFloat, CGFloat, CGFloat), end: (CGFloat, CGFloat, CGFloat), location: Double, opacity: Double) -> Gradient.Stop {
  
  let r = start.0 + CGFloat(location) * (end.0 - start.0)
  let g = start.1 + CGFloat(location) * (end.1 - start.1)
  let b = start.2 + CGFloat(location) * (end.2 - start.2)
  
  return Gradient.Stop(color: Color(uiColor: UIColor(red: r, green: g, blue: b, alpha: CGFloat(opacity))), location: CGFloat(location))
}

extension UIColor {
  var rgb: (CGFloat, CGFloat, CGFloat) {
    var fRed: CGFloat = 0
    var fGreen: CGFloat = 0
    var fBlue: CGFloat = 0
    var fAlpha: CGFloat = 0
    
    if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
      return (fRed, fGreen, fBlue)
    } else {
      return (0, 0, 0)
    }
  }
}

func generateGradient() -> [Gradient.Stop] {
  var gradientStops: [Gradient.Stop] = []
  for i in 0..<locations.count {
    gradientStops.append(gradientColor(start: startColorRGB, end: endColorRGB, location: locations[i], opacity: opacities[i]))
  }
  return gradientStops
}

struct ShareOverlayGradientBackgroundLayer: View, Equatable {
  static func == (lhs: ShareOverlayGradientBackgroundLayer, rhs: ShareOverlayGradientBackgroundLayer) -> Bool {
    true
  }

  var body: some View {
    Rectangle()
      .fill( EllipticalGradient(
        stops: generateGradient(),
        center: .bottom,
        startRadiusFraction: 0,
        endRadiusFraction: 1
      ))
      .offset(y: .screenH / 4)
  }
}

struct ShareOverlayGradientBackground: View, Equatable {
  static func == (lhs: ShareOverlayGradientBackground, rhs: ShareOverlayGradientBackground) -> Bool { true }

  @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
  @State private var opacities: [Double] = [1,1,1,1]
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ShareOverlayGradientBackgroundLayer().equatable().opacity(opacities[1]).drawingGroup().blendMode(.plusLighter)
    }
    .ignoresSafeArea(.all)
    .frame(.screenSize,  .bottom)
    .onReceive(timer) { _ in
      withAnimation(.smooth) {
        let min: Double = 0.5
        opacities = [.random(in: min...1), .random(in: min...1), .random(in: min...1), .random(in: min...1)]
      }
    }
  }
}
