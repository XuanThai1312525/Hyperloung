//
//  Font.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 11/9/21.
//

import Foundation
import UIKit

enum FontFamily {
    case system, customFont
    
    func displayFontWithSize(_ size: CGFloat, attributeType: FontAttribute = .regular) -> UIFont {
        switch self {
        case .customFont:
            return UIFont(name: fontNameFrom(attribute: attributeType), size: size) ?? UIFont.systemFont(ofSize: size)
        default:
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    func fontWithSize(_ size: CGFloat, attribute: String = "") -> UIFont {
        let attributeE = FontAttribute(rawValue: attribute) ?? .regular
        return displayFontWithSize(size, attributeType: attributeE)
    }
    
    private func fontNameFrom(attribute: FontAttribute) -> String {
        return "Spoqa Han Sans Neo " + attribute.rawValue
    }

    enum FontAttribute: String {
        case bold = "Bold", light = "Light", medium = "Medium", regular = "Regular", thin = "Thin"
    }
}
