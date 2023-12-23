//
//  ShareWall.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 19/09/23.
//

import SwiftUI

struct ShareWall: View {

  let triggerViewWidth: CGFloat = UIScreen.main.bounds.size.width / 5
  let triggerViewHeight: CGFloat = 100
  let triggerViewBottomPadding: CGFloat = 100

  var body: some View {
    GeometryReader { geo in
      ShareWallTrigger() {
        Color.clear
          .frame(width: triggerViewWidth, height: triggerViewHeight)
          .background(Color.clear)
          .contentShape(Rectangle())
      }
      .frame(width: geo.size.width, height: triggerViewHeight)
      .contentShape(Rectangle())
      .padding(.bottom, triggerViewBottomPadding + geo.safeAreaInsets.bottom)
      .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
    }
    .ignoresSafeArea(.all)
  }
}
