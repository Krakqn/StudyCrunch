//
//  Course.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation

struct Course: Identifiable {
  let id = UUID()
  let emoji: String
  let name: String
  let shortDescription: String?
  let longDescription: String?
  let sections: [Section]
  
  init(emoji: String, name: String, shortDescription: String? = nil, longDescription: String? = nil, sections: [Section]) {
    self.emoji = emoji
    self.name = name
    self.shortDescription = shortDescription
    self.longDescription = longDescription
    self.sections = sections
  }
  
  class Builder {
    var emoji: String? = nil
    var name: String? = nil
    var shortDescription: String? = nil
    var longDescription: String? = nil
    var chapterBuilders: [Chapter.Builder] = []
    
    init() {}
    
    @discardableResult func setEmoji(emoji: String) -> Builder {
      self.emoji = emoji
      return self
    }
    
    @discardableResult func setName(name: String) -> Builder {
      self.name = name
      return self
    }
    
    @discardableResult func setShortDescription(shortDescription: String) -> Builder {
      self.shortDescription = shortDescription
      return self
    }
    
    @discardableResult func setLongDescription(longDescription: String) -> Builder {
      self.longDescription = longDescription
      return self
    }
    
    @discardableResult func setDescription(description: String) -> Builder {
      self.shortDescription = description
      self.longDescription = description
      return self
    }
    
    @discardableResult func setChapterBuilders(chapterBuilders: [Chapter.Builder]) -> Builder {
      self.chapterBuilders = chapterBuilders
      return self
    }
    
    @discardableResult func addChapterBuilders(chapterBuilders: [Chapter.Builder]) -> Builder {
      self.chapterBuilders += chapterBuilders
      return self
    }
    
    func build() throws -> Course {
      guard
        let name = self.name
      else {
        throw BuildError.incompleteBuilder
      }
      
      let emoji = emoji ?? String(name[name.startIndex])
      let shortDescription = self.shortDescription ?? self.longDescription
      let longDescription = self.longDescription ?? self.shortDescription
      
      var sectionBuilders: [Section.Builder] = []
      var premiumChapters = [String]()
      for (index, chapterBuilder) in chapterBuilders.enumerated() {
        var append = true
        if let lastSectionBuilder = sectionBuilders.last {
          append = lastSectionBuilder.chapterBuilders.count >= 5
        }
        
        if append {
          sectionBuilders.append(Section.Builder()
            .setIndex(index: sectionBuilders.count)
            .setCourseName(courseName: name))
        }
        
        if let lastSectionBuilder = sectionBuilders.last {
          lastSectionBuilder
            .addChapterBuilders(chapterBuilders: [chapterBuilder])
        }
        // lock the last 2 chapters in each section
        if index % 5 == 3 || index % 5 == 4 {
          // key: course name + chapter number (symbol)
          // eg: "Computer Science2" corresponding to Computer Science Chapter 2
          let chapterKey = name + "\(index + 1)"
          premiumChapters.append(chapterKey)
        }
      }
      Global.lockChapters(premiumChapters)

      let sections = try sectionBuilders.map { try $0.build() }
      
      return Course(emoji: emoji, name: name, shortDescription: shortDescription, longDescription: longDescription, sections: sections)
    }
  }
}
