//
//  OnboardingTryingSomethingNew.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI

struct OnboardingTryingSomethingNew: View {
  var active: Bool
  var nextStep: ()->()
  var body: some View {
    OnboardingStepTemplate(image: {
      Image(systemName: "heart.fill")
        .fontSize(88, .semibold, .red)
        .symbolEffect(.bounce, options: .repeat(3), value: active)
    }, title: "We're trying something new", description: "We're trying to come up with a more efficient way to raise money, by offering a useful resource.", bodyContent: {
      VStack {
        VStack(spacing: 12) {
          Text("We will be donating all of our revenue to various non-profits.").fontSize(17, .semibold)
          Text("And we mean this. The reason there's a whole page for this is because of how important this is. It is a rampant problem, and we want to harness the power of motivated, studying students to help fix it.").fontSize(15).opacity(0.75)
          Text("Are you ready to help change the world?").fontSize(16, .semibold)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Color("acceptableBlack")))
      }
    }, buttonLabel: "Yes! We're in this together!", nextStep: nextStep)
  }
}
