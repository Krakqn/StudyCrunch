//
//  ShareMenu.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 11/4/23.
//

import Foundation
import SwiftUI

struct ShareMenu: View {
  //    @Binding var open: Bool
  //    @Binding var success: Bool
  
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack {
                    Text("Sharing is caring!")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                    Text("To unlock this note for free, just share it with a friend.")
                        .opacity(0.75)
                        .padding(2)
                }
                .multilineTextAlignment(.center)

                VStack(spacing: 6) {
                    HStack(spacing: 6) {
                        ShareButton(action: yourFunction)
                        ShareButton(action: yourFunction)
                        ShareButton(action: yourFunction)
                    }
                    HStack(spacing: 6) {
                        ShareButton(action: yourFunction)
                        ShareButton(action: yourFunction)
                        ShareButton(action: yourFunction)
                    }
                }
            }
            .padding(.top, 64)
            .padding(.horizontal, 16)
        }
    }
  
  func yourFunction() {
    // Add your code here
    print("Button tapped")
    // Call any other functions or perform actions you need
  }
}

struct ShareButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            Label("Share", systemImage: "square.and.arrow.up")
                .font(.system(size: 20).bold())
                .foregroundColor(Color("ForegroundColor"))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 16).stroke(Color("ForegroundColor"), lineWidth: 1))
        }
    }
}

#Preview {
  ShareMenu()
}

