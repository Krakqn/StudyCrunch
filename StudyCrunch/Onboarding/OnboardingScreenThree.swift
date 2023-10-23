//
//  OnboardingScreenThree.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import SwiftUI

struct OnboardingScreenThree: View { //Join Discord invite page
    @Binding var open: Bool
  //var prevStep: ()->()
  //var nextStep: ()->()
  @Environment(\.openURL) var openURL
  var body: some View {
      VStack(spacing: 16) {
          OnboardingCircle(step: 1)
          
          Text("Open Reddit API settings in Safari by clicking below's button, then, switch back to Winston.")
              .fixedSize(horizontal: false, vertical: true)
              .frame(maxWidth: 300)
          
          MasterButton(icon: "safari.fill", label: "Open Reddit API settings", colorHoverEffect: .animated, textSize: 18, height: 48, fullWidth: true, cornerRadius: 16, action: {
              //nextStep()
              withAnimation {
                open = false
              }
              openURL(URL(string: "https://reddit.com/prefs/apps")!)
          })
          .padding(.top, 32)
          
          MasterButton(label: "No Thanks", mode: .soft, color: .primary, colorHoverEffect: .animated, textSize: 18, height: 48, fullWidth: true, cornerRadius: 16, action: {
              withAnimation {
                open = false
              }
          })
//              .padding(.top, 32)
      }
    .padding(.horizontal, 16)
    .multilineTextAlignment(.center)
  }
}

////this is just for previewing
//struct OnboardingScreenThree_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingScreenThree {
//            //print("success")
//        }
//    }
//}

