//
//  pdfTest.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/27/23.
//

import Foundation
import SwiftUI
import PDFKit

//Source: 
//https://www.youtube.com/watch?v=hxKS8mZ-alE

let randomInfoURL = Bundle.main.url(forResource: "test", withExtension: "pdf")!

struct CustomPDFView: View {
  let title : String
  let displayedPDFURL: URL
  
  var body: some View {
    
    VStack {
      Text(title)
        .accessibilityLabel("Title of PDF")
        .accessibilityValue(title)
      PDFKitRepresentedView(documentURL : displayedPDFURL)
        .accessibilityLabel("PDF from: \(displayedPDFURL)")
        .accessibilityValue("PDF of: \(displayedPDFURL)")
    }
  }
}

struct PDFKitRepresentedView : UIViewRepresentable {
  let documentURL : URL
  
  init (documentURL : URL) {
    self.documentURL = documentURL
  }
  
  func makeUIView(context: Context) -> some UIView {
    let pdfView : PDFView = PDFView()
    
    pdfView.document = PDFDocument(url: self.documentURL)
    pdfView.autoScales = true
    pdfView.displayDirection = .vertical
    pdfView.minScaleFactor = 0.5
    pdfView.maxScaleFactor = 5.0
    
    return pdfView
  }
  
  func updateUIView(_ uiView : UIViewType, context : Context) -> Void {
    //Do not write any code in here!
  }
}

struct CustomPDFView_Previews: PreviewProvider {
  static var previews: some View {
    CustomPDFView(title: "PDF title", displayedPDFURL: randomInfoURL)
  }
}
