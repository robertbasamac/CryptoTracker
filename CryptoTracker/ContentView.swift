//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 13.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                
                Text("Accent color")
                    .foregroundColor(Color.theme.accennt)
                Text("Secondary Text color")
                    .foregroundColor(Color.theme.secondaryText)

                Text("Red color")
                    .foregroundColor(Color.theme.red)

                Text("Green color")
                    .foregroundColor(Color.theme.green)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
