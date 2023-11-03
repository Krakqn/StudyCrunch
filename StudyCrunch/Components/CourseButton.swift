//
//  CourseButton.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/24/23.
//

import SwiftUI

//struct UserLinkContainer: View {
//  var noHPad = false
//  @StateObject var user: User
//  var body: some View {
//    UserLink(noHPad: noHPad, user: user)
//  }
//}
//

struct CourseButton: View {
  var noHPad = false
  var emoji: String? = nil
  var label: String? = nil
  var subLabel: String? = nil
  var description: String? = nil
  var theme: AvatarTheme?
  @Environment(\.colorScheme) private var cs
  var body: some View {
    //let cornerRadius = (theme?.cornerRadius ?? (64 / 2))
    HStack(spacing: 12) {
      if let emoji = emoji {
        Group {
          Text(emoji)
            .font(.system(size: 64)) // Set the font size to match the avatar size
          // You can adjust the font further or use other modifiers as needed
          //.foregroundColor(.blue) // Example: Set a specific text color
          //.padding(10) // Example: Add padding
          //.background(Color.gray) // Example: Add a background color
          //.cornerRadius(8) // Example: Add corner radius
        }
        .frame(width: 64, height: 64)
        //.mask(RR(cornerRadius, .black))
      }
        VStack(alignment: .leading) {
          if let label = label {
            Text(label)
              .fontSize(18, .semibold)
          }
          if let subLabel = subLabel {
            Text(subLabel)
              .fontSize(14).opacity(0.5)
          }
          if let description = description {
            Text(description)
              .fontSize(15).opacity(0.75)
          }
        }
              .padding(.horizontal, noHPad ? 0 : 16)
              .padding(.vertical, 14)
              .frame(maxWidth: .infinity, alignment: .leading)
              .themedListRowBG()
              .mask(RR(20, .black))
              .onTapGesture {
                print("worked!!!!")
              }
    }
  }
}

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
