//
//  global.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/26/23.
//

import Foundation
import OSLog

struct Global {
  private static var premiumChapters = [String]()
  private static let logger = Logger(subsystem: "StudyCrunch", category: "Global")

  static func chapterLocked(_ chapterName: String) -> Bool {
    return UserDefaults.standard.bool(forKey: "\(chapterName)Locked")
  }

  static func unlockChapter(_ chapterName: String) {
    return UserDefaults.standard.setValue(false, forKey: "\(chapterName)Locked")
  }

  static func lockChapters(_ premiumChapters: [String]) { //lock chapters on first launch
    if !UserDefaults.standard.bool(forKey: "AppHasBeenLaunchedBefore") {
      logger.debug("lockChapters: \(premiumChapters)")
      self.premiumChapters = premiumChapters
      for chapterName in premiumChapters {
        UserDefaults.standard.setValue(true, forKey: "\(chapterName)Locked")
      }

      UserDefaults.standard.setValue(true, forKey: "AppHasBeenLaunchedBefore")
    }
  }

  static func unlockSection(_ section: Section) {
    logger.debug("unlockSection: \(section.name)")
    for chapter in section.chapters {
      let key = section.courseName + chapter.symbol
      unlockChapter(key)
    }
  }

  static func unlockEverything() {
    logger.debug("unlockEverything")
    for chapterName in premiumChapters {
      UserDefaults.standard.setValue(false, forKey: "\(chapterName)Locked")
    }
  }
}
