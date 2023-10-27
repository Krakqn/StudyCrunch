//
//  Course.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation

struct Course: Identifiable {
  var id = UUID()
  var emoji: String
  var name: String
  var shortDescription: String
  var longDescription: String
  var chapters: [Chapter]
}
