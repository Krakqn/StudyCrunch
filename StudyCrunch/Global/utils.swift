//
//  utils.swift
//  StudyCrunch
//
//  Created by Ethan Kim on 10/31/23.
//

import Foundation

enum InitError: Error {
  case `where`(String)
}

enum BuildError: Error {
  case incompleteBuilder, `where`(String)
}
