//
//  ContentView.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import SwiftUI
import Defaults
import AlertToast

struct ContentView: View {

  @Default(.showOnboarding) private var showOnboarding

  @EnvironmentObject private var viewModel: ViewModel

  @State private var selection = 0
  @State private var resetNavigationID = UUID()

  var body: some View {

    let selectable = Binding(        // << proxy binding to catch tab tap
      get: { self.selection },
      set: { self.selection = $0
        // set new ID to recreate NavigationView, so put it
        // in root state, same as is on change tab and back
        self.resetNavigationID = UUID()
      })

    TabView(selection: selectable) {
      NavigationView {
        CourseMenu(courses: [
          CSCourse().course,
          EnglishCourse().course,
        ])
      }
      .id(self.resetNavigationID)
      .tabItem {
        Label("Courses", systemImage: "book.closed")
      }
      .tag(0)
      .toast(isPresenting: $viewModel.showToast) {
        AlertToast(displayMode: .hud, type: .error(Color.red), title: "Action Failed", subTitle: "Please try again")
      }
      .toast(isPresenting: $viewModel.showPaymentSuccess) {
          AlertToast(
            displayMode: .banner(.slide),
            type: .complete(Color.white),
              title: "Donation Successful!",
              subTitle: "Thank you for your gratitude.",
              style: .style(
                  backgroundColor: Color.green,
                  titleColor: Color.white,
                  subTitleColor: Color.white,
                  titleFont: Font.system(size: 18, weight: .bold),
                  subTitleFont: Font.system(size: 16)
              )
          )
      }
      SettingsPage()
        .tabItem {
          Label("About", systemImage: "info.circle.fill")
        }
        .tag(1)
    }
    .sheet(isPresented: $showOnboarding, content: {
      OnboardingView().interactiveDismissDisabled()
    })
  }
}

#Preview {
  ContentView()
    .environment(\.colorScheme, .dark)
}
