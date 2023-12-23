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
//      if let nextCredIndex = RedditCredentialsManager.shared.credentials.firstIndex(of: cred) {
//        let curr = RedditCredentialsManager.shared.selectedCredential
//        var currCredIndex = -1
//        if let curr { currCredIndex = RedditCredentialsManager.shared.credentials.firstIndex(of: curr) ?? -1 }
//        accTransKit.willLensHeadLeft = Int(currCredIndex - nextCredIndex) <= 0
//        transmitter.selectedCred = nil
//        if #available(iOS 17.0, *) {
//          withAnimation(.snappy(extraBounce: 0.1)) { accTransKit.focusCloser = true } completion: {
//            withAnimation(.linear(duration: 0.001)) { accTransKit.blurMain = true; Defaults[.GeneralDefSettings].redditCredentialSelectedID = cred.id } completion: {
//              withAnimation(.spring) { accTransKit.passLens = true } completion: {
//                withAnimation(.spring) { transmitter.positionInfo = nil; accTransKit.blurMain = false; transmitter.screenshot = nil; accTransKit.focusCloser = false;  } completion: {
//                  accTransKit.passLens = false
//                }
//              }
//            }
//          }
//        } else {
//          // Fallback on earlier versions
//        }
//      } else {
//        doThisAfter(0) {
//          transmitter.reset()
//          Nav.present(.editingCredential(cred))
//        }
//      }
      transmitter.reset()
      DispatchQueue.main.async {
        if cred == "Share with email" {
          viewModel.isShowingMailView.toggle()
        } else if cred == "Share with iMessage" {
          viewModel.isShowingMessageView.toggle()
        }
      }
    } else {
      transmitter.scheduleReset(0.5)
    }
  }
  
  var body: some View {
    let showOverlay = (transmitter.positionInfo != nil && transmitter.showing) || accTransKit.focusCloser
//    let completelyFree = true
    let focusFramePadding: Double = !showOverlay ? 0 : accTransKit.focusCloser ? 40 : 16
    let frameSlideOffsetX = accTransKit.passLens ? (.screenW * (accTransKit.willLensHeadLeft ? -1 : 1)) : 0
    let somethingGoinOnYet = accTransKit.focusCloser || transmitter.showing
//    let parallaxW = .screenW * 0.25
    ZStack {
      
      ZStack {
        content()
          .blur(radius: accTransKit.blurMain ? 10 : 0)
//          .offset(x: accTransKit.passLens ? 0 : accTransKit.focusCloser ? (parallaxW * (accTransKit.willLensHeadLeft ? -1 : 1)) : 0)
          .environmentObject(transmitter)
          .zIndex(1)
        
        if let screenshot = transmitter.screenshot {
          Image(uiImage: screenshot).resizable().frame(.screenSize)
            .blur(radius: accTransKit.focusCloser ? 15 : transmitter.showing ? 10 : 0)
//            .offset(x: accTransKit.passLens ? (parallaxW * (accTransKit.willLensHeadLeft ? -1 : 1)) : 0)
            .background(.black)
//            .offset(x: frameSlideOffsetX / 5)
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
          .onChange(of: transmitter.showing) { initial in
            print("transmitter.showing: ", transmitter.showing, ", initial: ", initial)
            if !initial { selectCredential() }
          }
//          .onChange(of: transmitter.showing) { if !$0 { selectCredential() } }
          .allowsHitTesting(false)
      }
    }
    .ignoresSafeArea(.all)
    .allowsHitTesting(!(showOverlay || accTransKit.passLens))
    .environmentObject(viewModel)
  }
}
