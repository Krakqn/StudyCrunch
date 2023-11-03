//
//  Chapter.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/24/23.
//

import Foundation

struct Chapter: Identifiable {
  var id = UUID()
  var number: Int
  var name: String
  var access: Bool //self-explanatory
}
