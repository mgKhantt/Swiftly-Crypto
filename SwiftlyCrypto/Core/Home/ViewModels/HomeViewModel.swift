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
    
    @Published var searchText: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    private let dataService = CoinDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            //create a new publisher that create a new tuple (text, startingCoins)
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // wait 0.5s after the last keystroke before running
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coin: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coin
        }
        
        let lowercasedText = text.lowercased()
        
        return coin.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}
