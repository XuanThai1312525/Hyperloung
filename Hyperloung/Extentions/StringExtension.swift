//
//  StringExtension.swift
//  Hyperloung
//
//  Created by dongha on 11/11/2021.
//

import Foundation

extension String {
    var thousandString: String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.locale = Locale.current
        guard let number = currencyFormatter.number(from: self) else {
            return nil
        }
        return currencyFormatter.string(from: number)
    }

}
