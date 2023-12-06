//
//  global.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/26/23.
//

import Foundation

struct Global {
    static func chapterLocked(_ chapterName: String) -> Bool {
        return UserDefaults.standard.bool(forKey: "\(chapterName)Locked")
    }
    
    static func unlockChapter(_ chapterName: String) {
        return UserDefaults.standard.setValue(false, forKey: "\(chapterName)Locked")
    }
    
    static func lockChapters() { //lock chapters on first launch
        if !UserDefaults.standard.bool(forKey: "AppHasBeenLaunchedBefore") {
            UserDefaults.standard.setValue(true, forKey: "ArraysLocked")
            UserDefaults.standard.setValue(true, forKey: "PointersLocked")
            
            UserDefaults.standard.setValue(true, forKey: "AppHasBeenLaunchedBefore")
        }
    }
}
