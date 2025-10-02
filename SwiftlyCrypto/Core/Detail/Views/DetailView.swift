//
//  DetailView.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 02/10/2025.
//

import SwiftUI

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: dev.coin)
}
