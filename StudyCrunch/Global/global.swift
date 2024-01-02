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
  private static var premiumChapters = [String]()
  private static let logger = Logger(subsystem: "StudyCrunch", category: "Global")

  static func chapterLocked(_ chapterName: String) -> Bool {
    let locked = UserDefaults.standard.bool(forKey: "\(chapterName)Locked")
    return locked
  }

  static func unlockChapter(_ chapterName: String) {
    return UserDefaults.standard.setValue(false, forKey: "\(chapterName)Locked")
  }

  static func lockChapters(_ premiumChapters: [String], in courseName: String) { //lock chapters on first launch
    if !UserDefaults.standard.bool(forKey: "\(courseName)HasBeenLaunchedBefore") {
      logger.debug("lockChapters: \(premiumChapters)")
      self.premiumChapters = premiumChapters
      for chapterName in premiumChapters {
        UserDefaults.standard.setValue(true, forKey: "\(chapterName)Locked")
      }

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
    logger.debug("unlockEverything")
    for chapterName in premiumChapters {
      UserDefaults.standard.setValue(false, forKey: "\(chapterName)Locked")
    }
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
