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
    }, title: "We need your help", description: "This is a community effort. Feel free to contribute!", bodyContent: {
      VStack {
        VStack(spacing: 12) {
          Text("If you notice certain AP notes are missing, don't hesitate to contribute!").fontSize(17, .semibold)
          Text("We're all students striving towards the same goal. By uploading notes for classes you took previously, you will be helping countless students achieve their academic dreams.").fontSize(15).opacity(0.75)
          Text("Are you ready to help change the world?").fontSize(16, .semibold)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Color("acceptableBlack")))
      }
    }, buttonLabel: "Yes I am! Let's go!", nextStep: nextStep)
  }
}
