//
//  PortofolioView.swift
//  CryptoTracker
//
//  Created by Robert Basamac on 25.08.2022.
//

import SwiftUI

struct PortofolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)

                    coinLogoList
                    
                    if selectedCoin != nil {
                        portofolioInputSection
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portofolio")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortofolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortofolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortofolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 6) {
                ForEach(vm.searchText.isEmpty ? vm.portofolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 60, height: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(
                                    selectedCoin?.id == coin.id ?
                                        Color.theme.green :
                                        Color.clear, lineWidth: 1
                                )
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portofolioCoin = vm.portofolioCoins.first(where: { $0.id == coin.id }),
           let amount = portofolioCoin.currentHoldings {
            quantityText = String(amount)
        } else {
            quantityText = ""
        }
    }
    
    private var portofolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                
                Spacer()
                
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            
            Divider()
            
            HStack {
                Text("Amount holding:")
                
                Spacer()
                
                TextField("Ex. 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack {
                Text("Current value:")
                
                Spacer()
                
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ?
                    1.0 : 0.0
            )
        }
        .font(.headline)
        .foregroundColor(Color.theme.accent)
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save to portofolio
        vm.updatePortofolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
            quantityText = ""
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
        
        UIApplication.shared.endEditing()
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
