//
//  OnboardingCircle.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import SwiftUI

struct OnboardingCircle: View {
  var step: Int
  let size: CGFloat = 80
    var body: some View {
        Text("!")
        .fontSize(40, .bold)
        .frame(width: size, height: size)
        .background(.blue, in: Circle())
        .foregroundColor(.white)
    }
}
