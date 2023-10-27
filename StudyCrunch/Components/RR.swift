//
//  RR.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import SwiftUI

struct FilledRoundedRectangle: View {
    let cornerRadius: CGFloat
    let fill: any ShapeStyle
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(AnyShapeStyle(fill))
    }
}

func RR(_ cornerRadius: CGFloat, _ fill: any ShapeStyle) -> FilledRoundedRectangle {
    return FilledRoundedRectangle(cornerRadius: cornerRadius, fill: fill)
}
