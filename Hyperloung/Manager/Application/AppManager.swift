//
//  AppManager.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/25/21.
//

import Foundation
import UIKit

final class AppMainManager: HasAppProperties {
    static let shared = AppMainManager()
    
    var startingup = true
    func startup(_ window: UIWindow?, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        guard let window = window else {return}
        
        // prevent crash when scene invoke delegation functions
        guard startingup else {return}
        startingup = false
        
        navigator.startup(window)

    }
}
