//
//  HapticManager.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 26/09/2025.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
