//
//  dismissKeyboard.swift
//  StudyCrunch
//
//  Created by Sri Yanamandra on 10/23/23.
//

import Foundation
import UIKit

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

