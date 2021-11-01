//
//  AppProperties.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/25/21.
//

import Foundation

protocol HasAppProperties {
    var manager: AppMainManager {get}
    var navigator: AppMainNavigator {get}
}

extension HasAppProperties {
    var manager: AppMainManager {
        return AppMainManager.shared
    }
    
    var navigator: AppMainNavigator {
        return AppMainNavigator.shared
    }
}
