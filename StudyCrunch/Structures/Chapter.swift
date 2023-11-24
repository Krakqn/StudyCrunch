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
  var restricted: Bool
  var flashcards: [Flashcard] = []
  
  init(symbol: String, name: String, description: String? = nil, markdown: String, restricted: Bool = false, flashcards: [Flashcard] = []) {
    self.symbol = symbol
    self.name = name
    self.description = description
    self.markdown = markdown
    self.restricted = restricted
    self.flashcards = flashcards
  }
  
  class Builder {
    var index: Int? = nil
    var name: String? = nil
    var description: String? = nil
    var markdown: String? = nil
    var restricted: Bool = false
    var flashcards: [Flashcard] = []
    
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
    
    @discardableResult func setMarkdown(markdown: String) -> Builder {
      self.markdown = markdown
      return self
    }
  
    @discardableResult func setRestricted(restricted: Bool) -> Builder {
      self.restricted = restricted
      return self
    }
  
    @discardableResult func setFlashcards(jsonFileName: String) -> Builder {
      if let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json"), let data = try? String(contentsOf: url, encoding: .utf8), let newFlashcards = data.toObj([Flashcard].self) {
        self.flashcards = newFlashcards
      }
      return self
    }
    
    func build() throws -> Chapter {
      guard
        let index = self.index,
        let name = self.name,
        let markdown = self.markdown
      else {
        throw BuildError.incompleteBuilder
      }
      
      let symbol = "\(index + 1)"
      
      return Chapter(symbol: symbol, name: name, description: self.description, markdown: markdown, restricted: self.restricted, flashcards: flashcards)
    }
  }
}
