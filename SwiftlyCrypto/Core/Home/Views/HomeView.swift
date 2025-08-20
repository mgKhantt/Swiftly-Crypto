//
//  HomeView.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 19/08/2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                homeHeader
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
        }
    }
}



#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(dev.homeVM)
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .animation(.spring(), value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portflioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coins")
            Spacer()
            Text("Holdings")
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.accent)
        .padding(.horizontal)
    }
}
