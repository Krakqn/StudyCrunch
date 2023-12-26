//
//  ShareOverlayParticles.swift
//  winston
//
//  Created by Igor Marcossi on 28/11/23.
//

import SwiftUI
import SpriteKit
import AVKit

struct ShareOverlayParticles: View, Equatable {
  static var player = AVLooperPlayer(url: Bundle.main.url(forResource: "particle", withExtension: "mov")!)
  
  static func == (lhs: ShareOverlayParticles, rhs: ShareOverlayParticles) -> Bool { true }

  var body: some View {
    PPlayer(player: Self.player)
        .frame(.screenSize,  .bottom)
        .task { Self.player.play() }
        .onDisappear {
          let time = CMTime(seconds: Double(arc4random_uniform(16)), preferredTimescale: 1) // Random time between 0 and 15 seconds
          Self.player.seek(to: time)
          Self.player.pause()
        }
        .mask(Rectangle().fill(EllipticalGradient(colors: [.black, .black.opacity(0)], center: .bottom, startRadiusFraction: 0, endRadiusFraction: 0.75)))
        .blendMode(.screen)
        .onAppear {
          // Prevent background music from being paused
          do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
          } catch {

          }
        }
  }
}

struct PPlayer: UIViewRepresentable {
  var player: AVPlayer

  func makeUIView(context: Context) -> UIView {
    let view = PlayerView()
    view.player = self.player
    view.playerLayer.videoGravity = .resizeAspectFill
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    return view
  }

  func updateUIView(_ view: UIView, context: Context) { }

  class PlayerView: UIView {
      // Override the property to make AVPlayerLayer the view's backing layer.
      override static var layerClass: AnyClass { AVPlayerLayer.self }
      
      // The associated player object.
      var player: AVPlayer? {
          get { playerLayer.player }
          set { playerLayer.player = newValue }
      }
      
      var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
  }
}
