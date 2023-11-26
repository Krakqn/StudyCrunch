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
      }, title: "Welcome!", description: "This app is designed to revolutionize studying, cramming, and all other popular student activities. [INTRO WIP]. Lorem ipsum dolor sit amet, consectetur adipiscing elit.", bodyContent: {
        VStack {
          OnboardingWelcomeFeature(icon: "hare.fill", title: "Study quick", description: "Optimized notes for your convenience. Curated by professionals.")
          OnboardingWelcomeFeature(icon: "bolt.badge.clock.fill", title: "Learn quicker", description: "Extremely breif notes without any BS. Help save people.")
          OnboardingWelcomeFeature(icon: "heart.fill", title: "Benefit humanity", description: "All profits will go towards charity. Help save people.").accentColor(.red)
        }
      }, buttonLabel: "Okay! Tell me more!", nextStep: nextStep)
    }
}
