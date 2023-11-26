//
//  OnboardingView.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI
import Defaults

struct OnboardingView: View {
  @Default(.showOnboarding) private var showOnboarding
  @State private var currentTab = 0
  @Environment (\.colorScheme) var colorScheme: ColorScheme
  
  func nextStep() {
    if currentTab == 2 { return showOnboarding = false }
    withAnimation(.spring) {
      currentTab += 1
    }
  }
  
  func prevStep() {
    withAnimation(.spring) {
      currentTab -= 1
    }
  }
  
  var body: some View {
    TabView(selection: $currentTab) {
      OnboardingWelcome(active: currentTab == 0, nextStep: nextStep).tag(0)
      OnboardingTryingSomethingNew(active: currentTab == 1, nextStep: nextStep).tag(1)
      OnboardingDiscord(active: currentTab == 2, nextStep: nextStep).tag(2)
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    .onChange(of: currentTab) { _ in withAnimation { UIApplication.shared.dismissKeyboard() } }
  }
}

