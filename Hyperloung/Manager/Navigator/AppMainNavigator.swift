//
//  AppMainNavigator.swift
//  Hyperloung
//
//  Created by Thai Nguyen on 10/25/21.
//

import Foundation
import UIKit
import RxSwift

final class AppMainNavigator: NSObject {
    static let shared = AppMainNavigator()
    
    var window: UIWindow?
    var mainNavi: UINavigationController!
    let navigationQueue = DispatchQueue(label: "com.hyperloung.navigator.navigate")
    let disposeBag = DisposeBag()

    
    var appNotiToken: NSObjectProtocol?
    
    var openAddDeviceFromWelcome = false
    
    func startup(_ win: UIWindow?) {
        window = win
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .clear
        navigationBarAppearace.barTintColor = .clear
        setupRootView(window: win)
    }
    
    func setupRootView(window: UIWindow?) { //, role: RoleAccess
        let vc = UIViewController.make(UserInfoBasViewController.self)
        mainNavi = BaseNavigationVC(rootViewController:  vc)
        mainNavi.interactivePopGestureRecognizer?.isEnabled = false
        window?.rootViewController = mainNavi
    }}
