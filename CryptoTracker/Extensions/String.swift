//
//  String.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 02.09.2022.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
