//
//  OnboardingDiscord.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI

struct OnboardingDiscord: View {
  var active: Bool
  var nextStep: ()->()
  @Environment(\.openURL) var openURL
  var body: some View {
    OnboardingStepTemplate(image: {
      Image(systemName: "bubble.left.and.bubble.right.fill")
        .symbolRenderingMode(.hierarchical)
        .fontSize(72)
        .symbolEffect(.bounce, options: .repeat(1), value: active)
    }, title: "We need your feedback!", description: "This app is far from complete. Everything from suggesting features to getting free memberships takes place in our Discord.", bodyContent: {
      Button {
        openURL(appUrl)
      } label: {
        HStack(spacing: 12) {
          Image(.discordIcon).resizable().scaledToFit().frame(width: 48)
          VStack(alignment: .leading, spacing: 2) {
            Text("Join our discord!").fontSize(18, .semibold)
            Text("This is your invite to a community of trailblazers and problem solvers!").fontSize(16).opacity(0.75)
          }
        }
//        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color("discordColor").opacity(0.25)))
      }
      .buttonStyle(.plain)
    }, buttonLabel: "I have joined your ranks", nextStep: nextStep)
  }
}
