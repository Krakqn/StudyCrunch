//
//  ViewModel.swift
//  StudyCrunch
//
//  Created by Jun Gu on 2023/12/22.
//

import Foundation

class ViewModel: ObservableObject {
  @Published var isShowingMailView: Bool = false
  @Published var isShowingMessageView: Bool = false
  @Published var shareModalOpen: Bool = false
  @Published var showToast: Bool = false
  @Published var showPaymentSuccess: Bool = false
  @Published var newRound: Bool = false
  @Published var blurOpacity: CGFloat = 0.0
  @Published var isFlashcardFront: Bool = true
  @Published var isShowingFullscreenOverlay = false
  @Published var flashcardOverlayBackContent: String = ""
  @Published var flashcardOverlayFrontContent: String = ""
}
