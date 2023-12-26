//
//  MessageView.swift
//  StudyCrunch
//
//  Created by Martin Peshevski on 12/6/23.
//

import SwiftUI
import UIKit
import MessageUI

struct MessageView: UIViewControllerRepresentable {

    var message: String

    @Binding var isShowing: Bool
    @Binding var result: MessageComposeResult

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        
        @Binding var isShowing: Bool
        @Binding var result: MessageComposeResult

        init(isShowing: Binding<Bool>,
             result: Binding<MessageComposeResult>) {
            _isShowing = isShowing
            _result = result
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                   didFinishWith result: MessageComposeResult) {
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

    func makeUIViewController(context: UIViewControllerRepresentableContext<MessageView>) -> MFMessageComposeViewController {
        let vc = MFMessageComposeViewController()
        vc.messageComposeDelegate = context.coordinator
        vc.body = message
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController,
                                context: UIViewControllerRepresentableContext<MessageView>) {

    }
}
