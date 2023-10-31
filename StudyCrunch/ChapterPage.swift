//
//  ChapterView.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation
import SwiftUI



struct ChapterView: View {
  var chapter: Chapter
  @State private var spoiler: Bool
  
  init(chapter: Chapter) {
      self.chapter = chapter
      self._spoiler = State(initialValue: !chapter.access) //spoiler is true if you don't have access
  }
  
  //START OF COPY FROM htmlTEST (for testing purposes)
  
  @Environment (\.colorScheme) var colorScheme: ColorScheme
  
  var darkmodeModifications: String {
    return (colorScheme == .dark) ? """
          background-color: #000000;
          filter: invert(100%);
          """ : ""
  }
  
  var HTMLString: String {
    return """
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>History Notes</title>
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont;
        line-height: 1.6;
        margin: 20px;
        \(darkmodeModifications)
      }
      h2 {
        color: #333;
      }
      h3 {
        color: #666;
      }
      p {
        color: #444;
      }
    </style>
  </head>
  <body>
  
    <h2>Chapter 1: Mesopotamia</h2>
  
    <h3>Important Definitions and Dates:</h3>
    <ul>
      <li>Mesopotamia: Alluvial plain between the Tigris and Euphrates Rivers.</li>
      <li>Sumerians: Early creators of Mesopotamian culture, present from 5000 b.c.e.</li>
      <li>Semitic-speaking peoples: Supplanted Sumerians by 2000 b.c.e.</li>
      <li>City-states: Linked villages and cities, forming city-state systems.</li>
      <li>Lugal: Emerged as secular leaders in the third millennium b.c.e.</li>
      <li>Akkadian state: Founded by Sargon of Akkad around 2350 b.c.e.</li>
      <li>Third Dynasty of Ur: 2112–2004 b.c.e.</li>
      <li>Hammurabi: Established Old Babylonian state, known for Hammurabi's Law Code.</li>
    </ul>
  
    <h3>Important Concepts/Context/Information:</h3>
    <ul>
      <li>Challenging agricultural environment in Mesopotamia due to low rainfall and unpredictable river floods.</li>
      <li>Introduction of irrigation canals around 3000 b.c.e. improved agriculture.</li>
      <li>Variety of crops, natural resources, and draft animals.</li>
      <li>Rise of the Sumerians, followed by Semitic-speaking peoples who preserved Sumerian culture.</li>
      <li>City-states relied on villages for food surplus and provided protection and markets.</li>
      <li>Temples and palaces held political power; temples had religious power.</li>
      <li>Secular leadership (lugals) developed in the third millennium b.c.e.</li>
      <li>Territorial states emerged through absorption of city-states (e.g., Akkadian state, Third Dynasty of Ur).</li>
      <li>Trade played a crucial role in obtaining resources and goods.</li>
      <li>Mesopotamian society had three classes: free landowners, dependent farmers/artisans, and slaves.</li>
      <li>Status of women may have declined with the development of agriculture.</li>
      <li>Religion was an amalgamation of Sumerian and Semitic beliefs, with anthropomorphic gods.</li>
      <li>Technology included cuneiform writing, irrigation, metallurgy, and military advancements.</li>
      <li>Base-60 system and advances in mathematics and astronomy.</li>
      <li>Introduction of the wheel, chariots, and siege machinery.</li>
    </ul>
  
    <h2>Egypt</h2>
  
    <h3>Important Definitions and Dates:</h3>
    <ul>
      <li>Nile River: Defines Egypt's geography, "Gift of the Nile."</li>
      <li>Pharaohs: Egyptian kings considered gods on earth.</li>
      <li>Old, Middle, and New Kingdoms: Major periods in Egyptian history.</li>
      <li>Giza Pyramids: Constructed between 2550 and 2490 b.c.e.</li>
    </ul>
  
    <h3>Important Concepts/Context/Information:</h3>
    <ul>
      <li>Egypt's fertile "Black Land" alongside the Nile, surrounded by barren desert "Red Land."</li>
      <li>Agriculture relied on Nile floods and irrigation; cyclic worldview.</li>
      <li>Natural resources included papyrus, animals, building materials, and metals.</li>
      <li>Central administration governed through provincial and village bureaucracies.</li>
      <li>Hieroglyphics and cursive script used for writing on papyrus.</li>
      <li>Tensions between central and local governments; autonomy in weak central periods.</li>
      <li>Egyptian trade with Levant, Nubia, and Punt; resources exchanged.</li>
      <li>Egyptian society had distinct classes, with peasants as the majority.</li>
      <li>Limited-scale slavery with humane treatment.</li>
      <li>Women's status subordinate but with property rights.</li>
      <li>Religious beliefs focused on cyclical nature; pharaohs as gods.</li>
      <li>Construction of grand temples and emphasis on the afterlife.</li>
      <li>Extensive knowledge and technology in various fields.</li>
    </ul>
  
    <h2>Indus Valley Civilization</h2>
  
    <h3>Important Definitions and Dates:</h3>
    <ul>
      <li>Indus Valley: Flourished from 2600 to 1900 b.c.e.</li>
      <li>Harappa and Mohenjo-daro: Major urban centers of the Indus Valley civilization.</li>
    </ul>
  
    <h3>Important Concepts/Context/Information:</h3>
    <ul>
      <li>Indus Valley's reliance on the regular flooding of the Indus for agriculture.</li>
      <li>Limited knowledge of the people's identity, origins, and their advanced urban civilization.</li>
      <li>Uniformity in city planning, architecture, and brick size; possible central authority or trade.</li>
      <li>Access to metal resources led to advanced metallurgy.</li>
      <li>Achievements included irrigation, pottery, bronze metallurgy, and a writing system.</li>
      <li>Decline likely due to natural disasters and ecological changes.</li>
      <li>Ecological changes included drying up of the Hakra River and salinization.</li>
      <li>Collapse affected urban elites, but peasants adapted and survived.</li>
    </ul>
  
  </body>
  </html>
  """
  }
  
  //END OF COPY FROM htmlTEST (for testing purposes)
  
  var body: some View {
    VStack {
      VStack {
        HTMLView(htmlString: HTMLString)
      }
      .contentShape(Rectangle())
      .compositingGroup()
      .opacity(spoiler ? 0.55 : 1)
      .blur(radius: spoiler ? 12 : 0)
      .overlay(
        !spoiler
        ? nil
        : VStack {
          Spacer()
          //Text("It's a long text, we won't spam you with that without your consent.")
          Text("This note is locked! Since sharing is caring, we'll unlock it for you if you share the notes!")
            .opacity(0.75)
            .fontSize(14)
            .padding(.leading, 12)
            .padding(.trailing, 12)
          Text("Tap to share")
            .fontSize(16, .medium)
            .padding(.top, 5)
          Image(systemName: "square.and.arrow.up")
          Spacer()
        }
          .padding(.top, 72)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
          .contentShape(Rectangle())
          .onTapGesture {
            withAnimation {
              spoiler = false
            }
          }
      )
    }
  }
}
