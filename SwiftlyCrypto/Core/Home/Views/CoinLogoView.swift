//
//  CoinLogoView.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 24/09/2025.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(imageURL: coin.image, coinID: coin.id)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    Group {
        CoinLogoView(coin: dev.coin)
        CoinLogoView(coin: dev.coin)
    }
}
