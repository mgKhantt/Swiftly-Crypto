//
//  SwiftlyCryptoApp.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 19/08/2025.
//

import SwiftUI

@main
struct SwiftlyCryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
