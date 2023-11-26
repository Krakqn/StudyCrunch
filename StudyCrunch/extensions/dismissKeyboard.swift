//
//  dismissKeyboard.swift
//  StudyCrunch
//
//  Created by Igor Marcossi on 26/11/23.
//

import Foundation
import UIKit

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
