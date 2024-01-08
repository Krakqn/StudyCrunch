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
}
