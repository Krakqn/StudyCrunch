//
//  themedListRowBG.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/24/23.
//

import Foundation
import SwiftUI

let IPAD = UIDevice.current.userInterfaceIdiom == .pad

struct ThemedListRowBGModifier: ViewModifier {
  var enablePadding = false
  var disableBG = false
  var active = false
  @Environment(\.useTheme) private var theme
  @Environment(\.colorScheme) private var cs
  
  func body(content: Content) -> some View {
    let isActive = active && IPAD
    content
      .padding(.horizontal, enablePadding ? 16 : 0)
      .padding(.vertical, enablePadding ? 6 : 0)
      .frame(maxWidth: .infinity, minHeight: 45, alignment: .leading)
      .background(
        disableBG
        ? nil
        : Rectangle()
          .fill(theme.lists.foreground.blurry ? AnyShapeStyle(.bar) : AnyShapeStyle(isActive ? .blue : theme.lists.foreground.color.cs(cs).color()))
          .overlay(!theme.lists.foreground.blurry ? nil : Rectangle().fill(isActive ? .blue : theme.lists.foreground.color.cs(cs).color()))
          
      )
  }
}

extension View {
  func themedListRowBG(enablePadding: Bool = false, disableBG: Bool = false, active: Bool = false) -> some View {
    self
      .modifier(ThemedListRowBGModifier(enablePadding: enablePadding, disableBG: disableBG, active: active))
  }
}
