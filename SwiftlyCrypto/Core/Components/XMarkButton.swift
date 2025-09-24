//
//  XMarkButton.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 24/09/2025.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

#Preview {
    XMarkButton()
}
