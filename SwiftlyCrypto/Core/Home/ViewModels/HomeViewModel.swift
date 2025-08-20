//
//  HomeViewModel.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 20/08/2025.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portflioCoins: [CoinModel] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    private let dataService = CoinDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoin in
                self?.allCoins = returnedCoin
            }.store(in: &cancellable)
    }
}
