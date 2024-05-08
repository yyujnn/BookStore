//
//  Int+.swift
//  BookStore
//
//  Created by 정유진 on 2024/05/08.
//

import Foundation
extension Int {
    func formattedPriceWithWon() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedPrice = formatter.string(from: NSNumber(value: self)) ?? ""
        return "\(formattedPrice)원"
    }
}
