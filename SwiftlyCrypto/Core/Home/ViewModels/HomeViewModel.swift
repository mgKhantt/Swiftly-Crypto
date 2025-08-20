//
//  HomeViewModel.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 20/08/2025.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portflioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(dev.coin)
            self.portflioCoins.append(dev.coin)
        }
    }
}
