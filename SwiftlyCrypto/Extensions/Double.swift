//
//  Double.swift
//  SwiftlyCrypto
//
//  Created by Khant Phone Naing  on 20/08/2025.
//

import Foundation

extension Double {
    
    
    ///Converts a Double into a Currency with 2 decimal places
    ///```
    ///Convert 1234.56 to $1,234.56
    ///Convert 12.3456 to $12.3456
    ///Convert 1234.56 to $1,234.56
    ///```
    ///
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")  /*<- default value*/
        formatter.currencyCode = "usd" /*<-change currency*/
        formatter.currencySymbol = "$" /*<-change currency symbol*/
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///Converts a Double into a Currency with 2 decimal places
    ///```
    ///Convert 1234.56 to $1,234.56
    ///Convert 12.3456 to $12.3456
    ///Convert 1234.56 to $1,234.56
    ///```
    ///
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$00.00"
    }
    
    ///Converts a Double into a Currency with 2 decimal places
    ///```
    ///Convert 1234.56 to "1,234.56"
    ///```
    ///
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    ///Converts a Double into a Currency with 2-6 decimal places
    ///```
    ///Convert 1234.56 to "1,234.56%"
    ///```
    ///
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
}
