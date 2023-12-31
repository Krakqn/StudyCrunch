//
//  MailView.swift
//  StudyCrunch
//
//  Created by Martin Peshevski on 12/6/23.
//

import SwiftUI
import UIKit
import MessageUI

struct MailView: UIViewControllerRepresentable {

    var message: String

    @Binding var isShowing: Bool
    @Binding var result: MFMailComposeResult

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var isShowing: Bool
        @Binding var result: MFMailComposeResult

        init(isShowing: Binding<Bool>,
             result: Binding<MFMailComposeResult>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                isShowing = false
            }

            self.result = result
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setMessageBody(message, isHTML: false)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}
