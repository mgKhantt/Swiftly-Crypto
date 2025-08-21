//
//  CoinRowView.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 20/08/2025.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if showHoldingColumn {
                centerColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
        
    }
}

struct CoinImageView: View {
    
    @StateObject private var imageService: CoinImageService
        
    init(imageURL: String, coinID: String) {
        _imageService = StateObject(wrappedValue: CoinImageService(imageName: coinID, imageURL: imageURL))
    }
        
    var body: some View {
        
        Group {
            if let uiImage = imageService.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            } else {
                ProgressView()
                    .frame(width: 30, height: 30)
            }
        }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin: dev.coin, showHoldingColumn: true)
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(imageURL: coin.image ?? "NA", coinID: coin.id)
            
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }.foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text("\(coin.priceChangePercentage24H?.asPercentageString() ?? "")")
                .foregroundStyle(
                    ( coin.priceChangePercentage24H ?? 0 ) >= 0 ?
                    Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
