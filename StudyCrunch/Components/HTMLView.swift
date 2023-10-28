//
//  HTMLView.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/27/23.
//

import Foundation
import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
  
  let htmlString: String
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    uiView.loadHTMLString(htmlString, baseURL: nil)
  }
}
