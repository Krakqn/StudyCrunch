//
//  vibrate.swift
//  winston
//
//  Created by Igor Marcossi on 29/11/23.
//

import SwiftUI
import CoreHaptics
import OSLog


struct VibrateModifier<T: Equatable>: ViewModifier {

  var vibration: Vibration
  var value: T
  var disabled: Bool
  
  init(_ vibration: Vibration, trigger: T, disabled: Bool = false) {
    self.vibration = vibration
    self.value = trigger
    self.disabled = disabled
  }
  
  @StateObject private var hapticHolder = HapticHolder()
  @Environment(\.scenePhase) private var scenePhase
  func body(content: Content) -> some View {
    content
      .onAppear {
        hapticHolder.createAndStartHapticEngine()
        hapticHolder.createContinuousHapticPlayer()
      }
      .onDisappear {
        hapticHolder.stopEngine()
      }
      .onChange(of: value) { _ in
        guard !disabled else { return }
        switch vibration {
        case .continuous(let sharpness, let intensity):
          hapticHolder.playHapticContinuous(intensity: Float(intensity), sharpness: Float(sharpness))
        case .transient(let sharpness, let intensity):
          hapticHolder.playHapticTransient(intensity: Float(intensity), sharpness: Float(sharpness))
        }
      }
      .onChange(of: scenePhase) {
        switch $0 {
        case .active: hapticHolder.startEngine()
        case .background, .inactive: hapticHolder.stopEngine()
        @unknown default: break
        }
      }
  }
  
  enum Vibration {
    case continuous(sharpness: Double, intensity: Double)
    case transient(sharpness: Double, intensity: Double)
  }
  
  class HapticHolder: ObservableObject {

    private let logger = Logger(subsystem: "StudyCrunch", category: "HapticHolder")

    private var engine: CHHapticEngine? = nil
    private var continuousHapticTimer: Timer? = nil
    private var engineNeedsStart = true
    private var continuousPlayer: CHHapticAdvancedPatternPlayer? = nil
    private lazy var supportsHaptics: Bool = {
      return true//AppDelegate.instance?.supportsHaptics ?? false
    }()
    private let initialIntensity: Float = 1.0
    private let initialSharpness: Float = 0.5
    
    private func startPlayingContinuousHaptics() {
      guard supportsHaptics, let continuousPlayer = self.continuousPlayer else { return }
      
      do {
        try continuousPlayer.start(atTime: CHHapticTimeImmediate)
      } catch let error {
        logger.error("Error starting the continuous haptic player: \(error)")
      }
      
    }
    
    private func stopPlayingContinuousHaptics() {
      guard supportsHaptics, let continuousPlayer = self.continuousPlayer else { return }
      
      do {
        try continuousPlayer.stop(atTime: CHHapticTimeImmediate)
      } catch let error {
        self.logger.error("Error stopping the continuous haptic player: \(error)")
      }
      
    }
    
    func playHapticContinuous(intensity: Float, sharpness: Float) {
      guard supportsHaptics, let continuousPlayer = self.continuousPlayer else { return }
      
      if continuousHapticTimer == nil {
        self.startPlayingContinuousHaptics()
      }
      
      let intensityParameter = CHHapticDynamicParameter(parameterID: .hapticIntensityControl, value: intensity * initialIntensity, relativeTime: 0)
      let sharpnessParameter = CHHapticDynamicParameter(parameterID: .hapticSharpnessControl, value: sharpness * initialSharpness, relativeTime: 0)
      
      do {
        try continuousPlayer.sendParameters([intensityParameter, sharpnessParameter], atTime: 0)
      } catch let error {
        self.logger.error("Dynamic Parameter Error: \(error)")
      }
      
      setupTimer()
      
      func setupTimer() {
        continuousHapticTimer?.invalidate()
        continuousHapticTimer = .init(timeInterval: Date().timeIntervalSince1970 + 0.3, repeats: false, block: { _ in
          self.continuousHapticTimer = nil
          self.stopPlayingContinuousHaptics()
        })
      }
    }
    
    func playHapticTransient(intensity: Float, sharpness: Float) {
      
      guard supportsHaptics, let engine = self.engine else { return }
      
      let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
      let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
      let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParameter, sharpnessParameter], relativeTime: 0)
      
      do {
        let pattern = try CHHapticPattern(events: [event], parameters: [])
        let player = try engine.makePlayer(with: pattern)
        try player.start(atTime: CHHapticTimeImmediate)
      } catch let error {
        logger.error("Error creating a haptic transient pattern: \(error)")
      }
    }
    
    func stopEngine() {
      guard self.supportsHaptics, let engine = self.engine else { return }
      
      engine.stop(completionHandler: { error in
        if let error = error {
          self.logger.error("Haptic Engine Shutdown Error: \(error)")
          return
        }
        self.engineNeedsStart = true
      })
    }
    
    func startEngine() {
      guard self.supportsHaptics, let engine = self.engine else { return }
      
      engine.start(completionHandler: { error in
        if let error = error {
          self.logger.error("Haptic Engine Startup Error: \(error)")
          return
        }
        self.engineNeedsStart = false
      })
    }
    
    func createAndStartHapticEngine() {
      do {
        engine = try CHHapticEngine()
      } catch let error {
        fatalError("Engine Creation Error: \(error)")
      }
      guard let engine = engine else { return }
      
      engine.playsHapticsOnly = true
      
      // The stopped handler alerts you of engine stoppage.
      engine.stoppedHandler = { reason in
        self.logger.info("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
        switch reason {
        case .audioSessionInterrupt:
          self.logger.info("Audio session interrupt")
        case .applicationSuspended:
          self.logger.info("Application suspended")
        case .idleTimeout:
          self.logger.info("Idle timeout")
        case .systemError:
          self.logger.info("System error")
        case .notifyWhenFinished:
          self.logger.info("Playback finished")
        case .gameControllerDisconnect:
          self.logger.info("Controller disconnected.")
        case .engineDestroyed:
          self.logger.info("Engine destroyed.")
        @unknown default:
          self.logger.info("Unknown error")
        }
      }
      
      engine.resetHandler = {
        self.logger.info("Reset Handler: Restarting the engine.")
        do {
          try engine.start()
          self.engineNeedsStart = false
          self.createContinuousHapticPlayer()
        } catch {
          self.logger.error("Failed to start the engine")
        }
      }
      
      startEngine()
    }
    
    func createContinuousHapticPlayer() {
      guard let engine = engine else { return }
      let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: initialIntensity)
      let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: initialSharpness)
      
      let continuousEvent = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 100)
      
      do {
        let pattern = try CHHapticPattern(events: [continuousEvent], parameters: [])
        continuousPlayer = try engine.makeAdvancedPlayer(with: pattern)
      } catch let error {
        self.logger.error("Pattern Player Creation Error: \(error)")
      }
    }
    
  }
}





extension View {
  func vibrate<T: Equatable>(_ vibration: VibrateModifier<T>.Vibration, trigger: T, disabled: Bool = false) -> some View {
    self
      .modifier(VibrateModifier(vibration, trigger: trigger, disabled: disabled))
  }
}
