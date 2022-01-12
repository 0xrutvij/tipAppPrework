//
//  Helpers.swift
//  Prework
//
//  Created by Rutvij Shah on 1/10/22.
//
// swiftlint:disable all
import Foundation

struct CurrencyData: Codable {
    let currencies: [String: CurrencyInfo]
}

struct CurrencyInfo: Codable {
    let symbol: String
    let name: String
    let symbol_native: String
    let decimal_digits: Int
    let rounding: Float
    let code: String
    let name_plural: String
}

// swiftlint:enable all
