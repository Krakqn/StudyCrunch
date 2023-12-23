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
}
