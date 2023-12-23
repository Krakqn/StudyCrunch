//
//  ShareOverlayProvider.swift
//  winston
//
//  Created by Igor Marcossi on 27/11/23.
//

import SwiftUI
import Combine
import Defaults

class ShareOverlayTransmitter: ObservableObject {
  enum SwitchingState {
    case showing, hidden, selectedCred
  }
  private var cancellable: Timer? = nil
  @Published var positionInfo: PositionInfo? { willSet { self.cancellable?.invalidate() } }
  @Published var showing = false { willSet { if newValue { self.cancellable?.invalidate() } } }
  @Published var selectedCred: String? = nil
  @Published var screenshot: UIImage? = nil
  
  func scheduleReset(_ secs: Double) {
    cancellable = Timer.scheduledTimer(withTimeInterval: secs, repeats: false) { _ in
      self.reset()
    }
  }
  
  func reset() {
    self.cancellable?.invalidate()
    self.positionInfo = nil
    self.showing = false
    self.selectedCred = nil
    self.screenshot = nil
  }
  
  struct PositionInfo: Equatable, Hashable {
    static let zero = PositionInfo(.zero)
    private var _location: CGPoint? = nil
    var location: CGPoint {
      get { _location ?? initialLocation }
      set { _location = newValue }
    }
    var initialMovement: Bool { _location == nil }
    let initialLocation: CGPoint
    
    init(_ loc: CGPoint) {
      self.initialLocation = loc
    }
  }
}

struct ShareOverlayProvider<Content: View>: View {
  struct AccountTransitionKit: Equatable {
    var focusCloser: Bool = false
    var willLensHeadLeft: Bool = false
    var passLens: Bool = false
    var blurMain: Bool = false
  }
  
  @StateObject private var transmitter = ShareOverlayTransmitter()
  //  @State private var credIDToSelect: UUID? = nil
  @State private var accTransKit: AccountTransitionKit = .init()
  @StateObject private var viewModel = ViewModel()

  var content: () -> Content
  
  func selectCredential() {
    if let cred = transmitter.selectedCred {
      transmitter.reset()
      DispatchQueue.main.async {
        if cred == "Share with email" {
          viewModel.isShowingMailView.toggle()
        } else if cred == "Share with iMessage" {
          viewModel.isShowingMessageView.toggle()
        }
      }
    } else {
      withAnimation {
        transmitter.reset()
      }
    }
  }
  
  var body: some View {
    let showOverlay = (transmitter.positionInfo != nil && transmitter.showing) || accTransKit.focusCloser
    let frameSlideOffsetX = accTransKit.passLens ? (.screenW * (accTransKit.willLensHeadLeft ? -1 : 1)) : 0

    ZStack {
      
      ZStack {
        content()
          .blur(radius: accTransKit.blurMain ? 10 : 0)
          .environmentObject(transmitter)
          .zIndex(1)
        
        if let screenshot = transmitter.screenshot {
          Image(uiImage: screenshot).resizable().frame(.screenSize)
            .blur(radius: accTransKit.focusCloser ? 15 : transmitter.showing ? 10 : 0)
            .background(.black)
            .mask(Rectangle().fill(.black).offset(x: frameSlideOffsetX))
            .saturation(accTransKit.focusCloser ? 2 : transmitter.showing ? 1.75 : 1)
            .transition(.identity)
            .zIndex(2)
            .drawingGroup()
            .allowsHitTesting(false)
        }
      }
      .mask(
        Rectangle()
      )
      .background(.white)
      .animation(.spring, value: transmitter.showing)
      
      if let positionInfo = transmitter.positionInfo {
        ShareOverlayView(fingerPosition: positionInfo, appear: transmitter.showing, transmitter: transmitter).equatable().zIndex(3).allowsHitTesting(false)
          .zIndex(3)
          .onAppear { transmitter.showing = true }
          .onChange(of: transmitter.showing) { if !$0 { selectCredential() } }
          .allowsHitTesting(false)
      }
    }
    .ignoresSafeArea(.all)
    .allowsHitTesting(!(showOverlay || accTransKit.passLens))
    .environmentObject(viewModel)
  }
}
