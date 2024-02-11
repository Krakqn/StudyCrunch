//
//  OnboardingWelcome.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI
import Defaults
import UIKit

struct OnboardingWelcomeFeature: View {
  var icon: String
  var title: String
  var description: String
  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: icon).fontSize(32, .semibold, .accentColor).frame(width: 48)
      VStack(alignment: .leading, spacing: 2) {
        Text(title).fontSize(17, .semibold)
        Text(description).fontSize(15).opacity(0.75).frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 12)
    .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Color("acceptableBlack")))
  }
}

struct OnboardingWelcome: View {
  var active: Bool
  var nextStep: ()->()
    var body: some View {
      OnboardingStepTemplate(image: {
        Image(.appIconAsset)
          .resizable()
          .scaledToFit()
          .frame(width: 125, height: 125)
          .mask(RoundedRectangle(cornerRadius: 32, style: .continuous))
      }, title: "Welcome!", description: "This app is designed to revolutionize cramming. Experience the incredible efficiency of studying with curated notes at your fingertips.", bodyContent: {
        VStack {
          OnboardingWelcomeFeature(icon: "hare.fill", title: "Study quick", description: "Optimized notes for your convenience. Curated by professionals.")
          OnboardingWelcomeFeature(icon: "bolt.badge.clock.fill", title: "Learn quicker", description: "No time wasted. Find exactly what you need in mere seconds.")
          OnboardingWelcomeFeature(icon: "wifi.slash", title: "Completely offline", description: "Zero lag. No internet connection is required to access notes.")
        }
      }, buttonLabel: "Okay! Tell me more!", nextStep: nextStep)
    }
}
