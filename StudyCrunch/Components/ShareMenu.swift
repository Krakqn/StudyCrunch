//
//  ShareMenu.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 11/4/23.
//

import Foundation
import SwiftUI
import MessageUI

struct ShareMenu: View {
    @Binding var open: Bool
    var unlockName: String
  
    @State var resultMail: MFMailComposeResult = .failed
    @State var resultMessage: MessageComposeResult = .failed
    
//    @State var isShowingMailView = false
//    @State var isShowingMessageView = false

  @EnvironmentObject var viewModel: ViewModel

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
                
                VStack(spacing: 20) {
                    HStack(spacing: 6) {
                        if MFMailComposeViewController.canSendMail() {
                            Button("Show mail view") {
                              viewModel.isShowingMailView.toggle()
                            }
                            .padding()
                        }
                    }
                    HStack(spacing: 6) {
                        if MFMessageComposeViewController.canSendText() {
                            Button("Show message view") {
                              viewModel.isShowingMessageView.toggle()
                            }
                            .padding()
                        }
                    }
                }
            }
            .padding(.top, 64)
            .padding(.horizontal, 16)
            .sheet(isPresented: $viewModel.isShowingMessageView) {
              MessageView(message: "", isShowing: $viewModel.isShowingMessageView, result: self.$resultMessage)
            }
            .sheet(isPresented: $viewModel.isShowingMailView) {
              MailView(message: "", isShowing: $viewModel.isShowingMailView, result: self.$resultMail)
            }
            .onChange(of: resultMail) { oldValue, newValue in
                let success = resultMail == .sent || resultMessage == .sent
                if success {
                    Global.unlockChapter(unlockName)
                }
                open = !success
            }
            .onChange(of: resultMessage) { oldValue, newValue in
                let success = resultMail == .sent || resultMessage == .sent
                if success {
                    Global.unlockChapter(unlockName)
                }
                open = !success
            }
        }
    }
  
  func yourFunction() {
    // Add your code here
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

//#Preview {
//  ShareMenu(open: .constant(true), unlockName: "array")
//}

