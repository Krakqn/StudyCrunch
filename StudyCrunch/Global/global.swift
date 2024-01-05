//
//  global.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/26/23.
//

import Foundation
import OSLog
import UIKit
import SwiftUI

struct Global {
  private static let logger = Logger(subsystem: "StudyCrunch", category: "Global")

  private static let lockedChaptersKey = "lockedChaptersKey"

  static func isChapterLocked(_ chapterName: String) -> Bool {
    guard let lockedChapters = UserDefaults.standard.object(forKey: lockedChaptersKey) as? [String] else { return false }
    return lockedChapters.contains(chapterName)
  }

  static func unlockChapter(_ chapterName: String) {
    guard var lockedChapters = UserDefaults.standard.object(forKey: lockedChaptersKey) as? [String] else { return }
    lockedChapters.removeAll(where: { $0 == chapterName })
    UserDefaults.standard.setValue(lockedChapters, forKey: lockedChaptersKey)
  }

  static func lockChapters(_ premiumChapters: [String], in courseName: String) { //lock chapters on first launch
    if !UserDefaults.standard.bool(forKey: "\(courseName)HasBeenLaunchedBefore") {
      logger.debug("lockChapters: \(premiumChapters)")
      var lockedChapters = UserDefaults.standard.object(forKey: lockedChaptersKey) as? [String] ?? []
      lockedChapters.append(contentsOf: premiumChapters)
      UserDefaults.standard.setValue(lockedChapters, forKey: lockedChaptersKey)

      UserDefaults.standard.setValue(true, forKey: "\(courseName)HasBeenLaunchedBefore")
    }
  }

  static func unlockSection(_ section: Section) {
    logger.debug("unlockSection: \(section.name)")
    for chapter in section.chapters {
      let key = section.courseName + chapter.symbol
      unlockChapter(key)
    }
    NotificationCenter.default.post(name: Notification.Name("LockStateChanged"), object: nil)
  }

  static func unlockEverything() {
    guard let lockedChapters = UserDefaults.standard.object(forKey: lockedChaptersKey) as? [String] else { return }
    logger.debug("unlockEverything: \(lockedChapters)")
    UserDefaults.standard.setValue([String](), forKey: lockedChaptersKey)

    NotificationCenter.default.post(name: Notification.Name("LockStateChanged"), object: nil)
  }

  static func getColorScheme() -> ColorScheme {
    if let scheme = UIApplication.shared.windows.first?.windowScene?.traitCollection.userInterfaceStyle,
       scheme == .light {
      return .light
    }
    return .dark
  }
}
