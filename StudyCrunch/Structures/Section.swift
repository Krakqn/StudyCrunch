//
//  Section.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/31/23.
//

import Foundation

struct Section: Identifiable {
  let id = UUID()
  let symbol: String?
  let name: String
  let description: String?
  let chapters: [Chapter]
  let courseName: String

  init(symbol: String? = nil, name: String, description: String? = nil, chapters: [Chapter], courseName: String) throws {
    guard chapters.count <= 5 else {
      throw InitError.where("No more than five chapters allowed per section")
    }
    
    self.symbol = symbol
    self.name = name
    self.description = description
    self.chapters = chapters
    self.courseName = courseName
  }
  
  class Builder {
    var index: Int? = nil
    var courseName: String? = nil
    var chapterBuilders: [Chapter.Builder] = []
    
    init() {}
    
    @discardableResult func setIndex(index: Int) -> Builder {
      self.index = index
      return self
    }

    @discardableResult func setCourseName(courseName: String) -> Builder {
      self.courseName = courseName
      return self
    }

    @discardableResult func setChapters(chapterBuilders: [Chapter.Builder]) -> Builder {
      self.chapterBuilders = chapterBuilders
      return self
    }
    
    @discardableResult func addChapterBuilders(chapterBuilders: [Chapter.Builder]) -> Builder {
      self.chapterBuilders += chapterBuilders
      return self
    }
    
    func build() throws -> Section {
      guard let index = self.index, let courseName = courseName else {
        throw BuildError.incompleteBuilder
      }
      
      let symbol = "\(index + 1)"
      let name = "Section \(index + 1)"
      let chapters = try self.chapterBuilders.enumerated().map {
        try $1
          .setIndex(index: index * 5 + $0)
          .setCourseName(courseName: courseName)
          .build()
      }
      
      let start = index * 5, end = start + chapters.count - 1
      let description = "Chapters \(start + 1)-\(end + 1)"
      
      return try Section(symbol: symbol, name: name, description: description, chapters: chapters, courseName: courseName)
    }
  }
}
