//
//  Gesture.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 21/08/2025.
//


import SwiftUI
import UIKit
import Combine


func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder().resignFirstResponder), to: nil, from: nil, for: nil)
}

struct KeyboardObserver: ViewModifier {
    
    @State private var isKeyboardVisible: Bool = false
    private var keyboardShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
    private var keyboardHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
    
    func body(content: Content) -> some View {
        content
            .onReceive(keyboardShow) { _ in
                isKeyboardVisible = true
            }
            .onReceive(keyboardHide) { _ in
                isKeyboardVisible = false
            }
            .overlay {
                Group {
                    if isKeyboardVisible {
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                hideKeyboard()
                            }
                    }
                }
            }
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.modifier(KeyboardObserver())
    }
}
