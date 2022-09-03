//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 13.08.2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ZStack {
                    HomeView()
                        .navigationBarTitleDisplayMode(.automatic)
                        .toolbar(.hidden)
                    
                    ZStack {
                        if showLaunchView {
                            LaunchView(showLaunchView: $showLaunchView)
                                .transition(.move(edge: .leading))
                        }
                    }
                    .zIndex(2.0) // to not  hide the LaunchView behind the HomeView when transitioning -> it will always be in front
                }
            }
            .environmentObject(vm)
        }
    }
}
