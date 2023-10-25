//
//  CourseHome.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/24/23.
//

import Foundation
import SwiftUI

//private struct Feature: View {
//    var icon: String
//    var title: String
//    @Environment(\.colorScheme) var colorScheme: ColorScheme
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            Image(systemName: icon)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 40)
////                .foregroundColor(.blue) // Adjust the color as needed
//            
//            Text(title)
//                .font(.system(size: 34, weight: .semibold))
//        }
//        .padding(.leading, 12)
//        .padding(.vertical, 12)
//        .padding(.trailing, 16)
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
//            .fill(Color.black.opacity(colorScheme == .dark ? 0.2 : 0.05)))
//    }
//}

//// Example of usage
//CustomButtonWithText(
//    masterButton: MasterButton(
//        icon: "party.popper.fill",
//        label: "Start using Winston!",
//        colorHoverEffect: .animated,
//        textSize: 18,
//        height: 48,
//        fullWidth: true,
//        cornerRadius: 16,
//        action: {
//            withAnimation {
//                open = false
//            }
//        }
//    ),
//    secondaryLabel: "Guide me"
//)

//struct UserLinkContainer: View {
//  var noHPad = false
//  @StateObject var user: User
//  var body: some View {
//    UserLink(noHPad: noHPad, user: user)
//  }
//}
//
//struct UserLink: View {
//  var noHPad = false
//  var user: User
//  @EnvironmentObject private var routerProxy: RouterProxy
//    var body: some View {
//      if let data = user.data {
//        HStack(spacing: 12) {
//          Avatar(url: data.icon_img, userID: data.name, avatarSize: 64)
//          
//          VStack(alignment: .leading) {
//            Text("u/\(data.name)")
//              .fontSize(18, .semibold)
//            Text("\(formatBigNumber(data.total_karma ?? ((data.link_karma ?? 0) + (data.comment_karma ?? 0)))) karma")
//              .fontSize(14).opacity(0.5)
//            if let description = data.subreddit?.public_description {
//              Text((description).md()).lineLimit(2)
//                .fontSize(15).opacity(0.75)
//            }
//          }
//        }
//        .padding(.horizontal, noHPad ? 0 : 16)
//        .padding(.vertical, 14)
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .themedListRowBG()
//        .mask(RR(20, .black))
//        .onTapGesture {
//          routerProxy.router.path.append(user)
//        }
//      }
//    }
//}


struct CourseHome: View {
  var nextStep: ()->()
  var body: some View {
  ScrollView {
    VStack(spacing: 24) {
      //        Image("winstonNoBG")
      //          .resizable()
      //          .scaledToFit()
      //          .frame(height: 128)
      //          .transition(.scale(scale: 1))
      
      VStack {
        Text("Welcome!")
          .fontSize(24, .semibold)
        Text("To use Reddit, Winston uses a special key you can generate yourself in Reddit's site.")
          .opacity(0.75)
      }
      .multilineTextAlignment(.center)
      
//      VStack(spacing: 6) {
//        Feature(icon: "arrow.up", title: "Huge limit", description: "Reddit API limit is 100 requests per second, it's impossible to reach.")
//        Feature(icon: "dollarsign", title: "No costs at all", description: "Even if you pass the limit, there will be no charges, you only get an error.")
//        Feature(icon: "point.topleft.down.curvedto.point.bottomright.up.fill", title: "Easy to setup", description: "It's really easy to get set Winston up. We'll guide all the way!")
//        Feature(icon: "eye.slash.fill", title: "Safe and private", description: "The key is **only** stored in your iCloud keychain, we can't read it.")
//      }
      
      MasterButton(emoji: "👋", label: "Ok then, guide me", colorHoverEffect: .animated, textSize: 18, height: 48, fullWidth: true, cornerRadius: 16, action: nextStep)
        .padding(.top, 32)
    }
    .padding(.top, 64)
    .padding(.horizontal, 16)
  }
}
}

//// Preview
//struct CourseHome_previews: PreviewProvider {
//    static var previews: some View {
//        CourseHome {
//            //print("success")
//        }
//    }
//}

