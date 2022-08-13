//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 13.08.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortofolio: Bool = false
    
    var body: some View {
        
        ZStack {
            // background layer
            Color.theme.background
            
            // content layer
            VStack {
                homeHeader
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden)
        }
    }
}


extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortofolio ? "plus" : "info")
                .animation(.none, value: showPortofolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortofolio)
                )
            
            Spacer()
            
            Text(showPortofolio ? "Portofolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accennt)
                .animation(.none, value: showPortofolio)

            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortofolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortofolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
