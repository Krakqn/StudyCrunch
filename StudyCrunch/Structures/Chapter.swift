//
//  Chapter.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation

struct Chapter: Identifiable {
  let id = UUID()
  let symbol: String
  let name: String
  let description: String?
  let markdown: String
  let courseName: String
  let pdfData: Data?

  var restricted: Bool {
    let key = courseName + symbol
    return Global.isChapterLocked(key)
  }
  var flashcards: [Flashcard] = []
  
  init(symbol: String, name: String, description: String? = nil, markdown: String, flashcards: [Flashcard] = [], courseName: String, pdfData: Data?) {
    self.symbol = symbol
    self.name = name
    self.description = description
    self.markdown = markdown
    self.flashcards = flashcards
    self.courseName = courseName
    self.pdfData = pdfData
  }
  
  class Builder {
    var index: Int? = nil
    var name: String? = nil
    var description: String? = nil
    var markdown: String? = nil
    var restricted: Bool = false
    var flashcards: [Flashcard] = []
    var courseName: String? = nil
    var pdfData: Data? = nil

    init() {}
    
    @discardableResult func setIndex(index: Int) -> Builder {
      self.index = index
      return self
    }
    
    @discardableResult func setName(name: String) -> Builder {
      self.name = name
      return self
    }
    
    @discardableResult func setDescription(description: String) -> Builder {
      self.description = description
      return self
    }
    
    @discardableResult func setMarkdown(markdownFilename: String) -> Builder {
      if let url = Bundle.main.url(forResource: markdownFilename, withExtension: "md"),
         let markdown = try? String(contentsOf: url, encoding: .utf8) 
      {
        self.markdown = markdown
      }
      return self
    }
  
    @discardableResult func setFlashcards(jsonFileName: String) -> Builder {
      if let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json"), let data = try? String(contentsOf: url, encoding: .utf8), let newFlashcards = data.toObj([Flashcard].self) {
        self.flashcards = newFlashcards
      }
      return self
    }

    @discardableResult func setCourseName(courseName: String) -> Builder {
      self.courseName = courseName
      return self
    }

    @discardableResult func setPdfData(filename: String) -> Builder {
      var filename = filename
      if Global.getColorScheme() == .dark { filename += "Dark" }
      if let url = Bundle.main.url(forResource: filename, withExtension: "pdf"),
         let pdfData = try? Data(contentsOf: url)
      {
        self.pdfData = pdfData
      }
      return self
    }

    func build() throws -> Chapter {
      guard
        let index = self.index,
        let name = self.name,
        let markdown = self.markdown,
        let courseName = self.courseName
      else {
        throw BuildError.incompleteBuilder
      }
      
      let symbol = "\(index + 1)"
      
      return Chapter(symbol: symbol, name: name, description: self.description, markdown: markdown, flashcards: flashcards, courseName: courseName, pdfData: pdfData)
    }
  }
}
