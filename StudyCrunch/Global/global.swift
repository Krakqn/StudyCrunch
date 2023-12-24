//
//  global.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/26/23.
//

import Foundation

struct Global {
  private static let premiumChapters = [
    "Arrays",
    "Pointers"
  ]
  static func chapterLocked(_ chapterName: String) -> Bool {
    return UserDefaults.standard.bool(forKey: "\(chapterName)Locked")
  }

  static func unlockChapter(_ chapterName: String) {
    return UserDefaults.standard.setValue(false, forKey: "\(chapterName)Locked")
  }

  static func lockChapters() { //lock chapters on first launch
    if !UserDefaults.standard.bool(forKey: "AppHasBeenLaunchedBefore") {
      for chapterName in premiumChapters {
        UserDefaults.standard.setValue(true, forKey: "\(chapterName)Locked")
      }

      UserDefaults.standard.setValue(true, forKey: "AppHasBeenLaunchedBefore")
    }
  }

  static func unlockSection(_ section: Section) {
    for chapter in section.chapters {
      unlockChapter(chapter.name)
    }
  }

  static func unlockEverything() {
    for chapterName in premiumChapters {
      UserDefaults.standard.setValue(false, forKey: "\(chapterName)Locked")
    }
  }
}
