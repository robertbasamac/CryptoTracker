//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 13.08.2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}
