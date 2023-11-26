//
//  OnboardingStepTemplate.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI

struct OnboardingStepTemplate<ImageContent: View, BodyContent: View>: View {
  var image: (() -> ImageContent)? = nil
  var title: String
  var description: String
  @ViewBuilder var bodyContent: () -> BodyContent
  var buttonLabel: String = "Next"
  var nextStep: () -> ()

  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack(spacing: 0) {
          VStack(spacing: 24) {
            VStack(spacing: 16) {
              image?()
              VStack(spacing: 8) {
                Text(title).fontSize(28, .bold)
                Text(description).opacity(0.75)
              }
              .padding(.horizontal, 16)
              .multilineTextAlignment(.center)
            }
            bodyContent()
          }
            Spacer()
            FatButton(buttonLabel, nextStep)
        }
        .padding(.top, 40)
        .padding(.bottom, 24)
        .padding(.horizontal, 16)
        .frame(minHeight: geo.size.height - 16)
      }
    }
  }
}
