//
//  UIViewControllerExtension.swift
//  Earable
//
//  Created by Tung Nguyen on 11/14/19.
//  Copyright © 2019 Earable. All rights reserved.
//

import UIKit

extension UIViewController {
    static func make<T: UIViewController>(_ type: T.Type) -> T {
        var sb: UIStoryboard?
        switch type {
        case is LoginViewController.Type,
             is MainReportViewController.Type,
             is DetailReportViewController.Type,
             is UserInfoBasViewController.Type,
             is HomeViewController.Type:
            sb = UIStoryboard.main
            
        default:
            break
        }
        return sb?.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    func inNavigation(_ navi: UINavigationController) -> Bool {
        return navigationController === navi
    }
    
    var previousViewController: UIViewController? {
        guard let navi = navigationController,
              let index = navi.viewControllers.lastIndex(of: self),
              index > 0 else {
            return nil
        }
        return navi.viewControllers[index - 1]
    }
    
}

extension UINavigationController {
    var rootViewController: UIViewController? {
        return viewControllers.first
    }
    
    func first<T: UIViewController>(where type: T.Type) -> T? {
        return viewControllers.first(where: { $0.self is T }) as? T
    }
    
    func last<T: UIViewController>(where type: T.Type) -> T? {
        return viewControllers.last(where: { $0.self is T }) as? T
    }
}
