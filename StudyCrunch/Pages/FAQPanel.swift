//
//  FAQPanel.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 12/21/23.
//

import SwiftUI
import Defaults

struct FAQPanel: View {
  @Binding var open: Bool
  @Environment (\.colorScheme) var colorScheme: ColorScheme
  
  func nextStep() {
    open = false
  }
  
  var body: some View {
    GeometryReader { geo in
      VStack{
        List{ // placeholder text, copied from winston at the moment (will change later)
          QuestionAnswer(question: "What is Cramberry?", answer: "Cramberry is a **100% free to use** tool to help you cram smarter for tests. Curated notes are stored locally, so no internet is needed to access them (if you unlock them first)!", systemImage: "questionmark.circle")
          QuestionAnswer(question: "Why did we start Cramberry?", answer: "A group of friends who had just graduated high school (that's us!) decided to share our old notes with friends still in school. Turns out they loved having a handy study tool, so we made Cramberry public to help all students cram smarter! We're also using Cramberry to experiment with effective altruism and see if providing these useful study tools inspires more people to donate to a good cause.", systemImage: "questionmark.circle")
          QuestionAnswer(question: "Why is [insert AP Class] not on here?", answer: "If you don’t see an AP you want to study, you can request it in our Discord or using the feedback button. We prioritize adding AP classes by the number of requests they receive, so if you really want notes for a certain AP subject, make sure to let us know. We're also always adding more, so check back frequently to see if it has been added. And feel free to donate your own notes to share! Contributors get added to the official Cramberry team (and therefore can list it as an extracurricular activity 👀). Reach out on Discord to learn more!", systemImage: "questionmark.circle")
          QuestionAnswer(question: "If I use Cramberry, can I skip studying?", answer: "You can try! But Cramberry is made for cramming, so some details may be missing. Use it to get familiar with the material before class or while studying. Do what works best for you!", systemImage: "questionmark.circle")
          QuestionAnswer(question: "Why are some chapters locked? Can I unlock everything at once?", answer: "We're running an experiment to see if offering a product works better than just asking for donations when raising money [(effective altruism)](https://orgs.law.harvard.edu/effectivealtruism/about-us/about-effective-altruism/). But you can unlock all chapters with a one-time 99 cent donation, which we'll give to a different charity each month (with donation proof posted in Discord).", systemImage: "questionmark.circle")
          QuestionAnswer(question: "Can I use Cramberry for free?", answer: "Absolutely! We believe quality educational material should be freely accessible to all. Just share any locked chapter, and the whole section (a group of five chapters) will unlock permanently, including any other locked chapters. Everything can be unlocked for free by sharing!", systemImage: "questionmark.circle")
          QuestionAnswer(question: "Why does Cramberry only have notes for AP classes and not regular high school subjects?", answer: "Since AP classes go more in-depth than regular high school courses, the AP notes on Cramberry also cover the main concepts and materials of the regular versions. So if you're taking the regular Biology class, the AP Biology notes can still help you cram!", systemImage: "questionmark.circle")
          QuestionAnswer(question: "Why iOS only? Will Cramberry ever be on other devices?", answer: "We saw most students cramming on their iPhones right before tests. So we started with iOS to make it easy to study on-the-go! But if enough people want Cramberry on Android or the web, we’ll expand to those platforms. Just let us know through the feedback form.", systemImage: "questionmark.circle")
          QuestionAnswer(question: "Can I join the Cramberry team?", answer: "Absolutely! Feel free to reach out on Discord and say hi.", systemImage: "questionmark.circle")
        }
        Spacer()
        FatButton("Okay!", nextStep)
      }
      .frame(minHeight: geo.size.height - 16)
    }
  }
}

struct QuestionAnswer: View {
  var question: String
  var answer: String
  var systemImage: String?
  var body: some View {
    VStack{
      HStack{
        if let systemImage {
          Image(systemName: systemImage)
        }
        Text(.init(question))
        Spacer()
      }
      .fontWeight(.bold)
      .font(.system(.headline))
      .padding(.bottom, 5)
      HStack{
        Text(.init(answer))
        Spacer()
      }
    }
  }
}

//#Preview {
//  FAQPanel()
//    .environment(\.colorScheme, .light)
//}

