//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 23.08.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
