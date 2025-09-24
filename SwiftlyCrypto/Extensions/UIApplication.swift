//
//  Gesture.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 21/08/2025.
//


import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder().resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
