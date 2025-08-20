//
//  CoinDataService.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 20/08/2025.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscriptions: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        coinSubscriptions = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            // Run the network request and mapping work on a background thread
            
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            // Validate the HTTP response.
            // If it’s not in the 200–299 range, throw an error.
            // Otherwise, pass along the raw data.
            
            .receive(on: DispatchQueue.main)
            // Deliver the results back on the main thread
            // (important for updating @Published vars / UI)
            
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            // Decode the raw JSON data into an array of CoinModel
            
            .sink { completion in
                switch completion {
                    case .finished:
                        // The publisher completed successfully
                        break
                    case .failure(let error):
                        // Handle errors (network, decoding, bad response, etc.)
                        print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedData in
                // Successfully received the decoded [CoinModel] and add to append
                self?.allCoins = returnedData
                self?.coinSubscriptions?.cancel()
            }
    }

}
