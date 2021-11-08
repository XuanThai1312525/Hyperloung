//
//  UIFontExtension.swift
//  Hyperloung
//
//  Created by dongha on 08/11/2021.
//

import UIKit

extension UIFont {
    static func normal(size: CGFloat = 12) -> UIFont {
        UIFont(name: "SpoqaHanSansNeo-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(size: CGFloat = 12) -> UIFont {
        UIFont(name: "SpoqaHanSansNeo-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }

}
