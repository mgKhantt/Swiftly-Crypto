//
//  XMarkButton.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 24/09/2025.
//

import SwiftUI

struct XMarkButton: View {
    @Binding var showPortfolioView: Bool
    
    var body: some View {
        Button {
            showPortfolioView = false
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }

    }
}

#Preview {
    XMarkButton(showPortfolioView: .constant(false))
}
