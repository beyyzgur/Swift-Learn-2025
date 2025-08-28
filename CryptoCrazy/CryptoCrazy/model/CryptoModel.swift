//
//  CryptoModel.swift
//  CryptoCrazy
//
//  Created by beyyzgur on 27.08.2025.
//

import Foundation

struct CryptoModel : Codable {
    let currency: String
    let price: String
    
    init(currency: String, price: String) {
        self.currency = currency
        self.price = price
    }
}
