//
//  Flashcard.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 23/11/23.
//

import Foundation

struct Flashcard: Codable, Identifiable, Hashable, Equatable {
  var id: String { front + back }
  var front: String
  var back: String
}
