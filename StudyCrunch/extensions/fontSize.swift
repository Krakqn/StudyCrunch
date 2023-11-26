//
//  fontSize.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import SwiftUI

extension View {
  func fontSize(_ size: CGFloat, _ weight: Font.Weight = .regular,  _ color: Color = .primary, _ design: Font.Design = .default) -> some View {
    self.font(.system(size: size, weight: weight, design: design)).foregroundStyle(color)
  }
}
