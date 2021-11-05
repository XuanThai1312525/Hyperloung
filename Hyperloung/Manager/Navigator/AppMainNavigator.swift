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
        let vc = UIViewController.make(HomeViewController.self)
        mainNavi = BaseNavigationVC(rootViewController:  vc)
        mainNavi.interactivePopGestureRecognizer?.isEnabled = false
        window?.rootViewController = mainNavi
        window?.makeKeyAndVisible()
    }
    
    
    func presentVC<T: UIViewController>(_ vcType: T.Type, in navi: UINavigationController, in context: NavigationContext) {
        if let fromVC = context.fromVC, fromVC.inNavigation(navi) {
            let vc = navi.first(where: vcType)
            if vc == nil {
                showVC(context.toVC(UIViewController.make(vcType)))
            } else {
                popToVC(context.toVC(vc))
            }
        } else {
            let vc = UIViewController.make(vcType)
            showVC(NavigationContext()
                .fromVC(navi)
                .toVC(vc)
                .animated(false))
            context.prepareData?(context.toVC(vc))
            presentVC(context.toVC(navi))
        }
    }

    
    func presentPopupVC(_ context: NavigationContext) {
        context.prepareData?(context)
        if #available(iOS 13.0, *) {
            navigateViewController(context.type(.present(.automatic)))
        } else {
            // Fallback on earlier versions
            context.toVC?.view.backgroundColor = #colorLiteral(red: 0.3818607234, green: 0.3818607234, blue: 0.3818607234, alpha: 0.5)
            navigateViewController(context.type(.present(.overCurrentContext)))
        }
    }
    

    
    func pop(_ context: NavigationContext) {
        popToVC(context.toVC(context.fromVC?.previousViewController))
    }
    
    func pop<T: UIViewController>(_ context: NavigationContext, to VCType: T.Type) {
        popToVC(context.toVC(context.fromVC?.navigationController?.last(where: VCType)))
    }
    
    func popToVC(_ context: NavigationContext) {
        context.prepareData?(context)
        navigateViewController(context.type(.pop))
    }
    
    func presentNavi(_ context: NavigationContext) {
        let navi = context.toVC?.navigationController
        context.prepareData?(context)
        navigateViewController(context.toVC(navi).type(.present(.fullScreen)))
    }
    
    func presentVC(_ context: NavigationContext, type: UIModalPresentationStyle = .fullScreen) {
        context.prepareData?(context)
        navigateViewController(context.type(.present(type)))
    }
    
    func showVC(_ context: NavigationContext) {
        context.prepareData?(context)
        navigateViewController(context.type(.push))
    }
}

extension AppMainNavigator {
    func navigateViewController(_ context: NavigationContext) {
        if context.afterSec > 0.0 {
            navigationQueue.asyncAfter(deadline: DispatchTime.now() + context.afterSec) {
                DispatchQueue.main.sync { [weak self] in
                    guard let `self` = self else {return}
                    context.afterSecondsCompletion?()
                    self.navigateViewController(context.afterSec(0.0))
                }
            }
            return
        } else if !Thread.isMainThread {
            DispatchQueue.main.sync { [weak self] in
                guard let `self` = self else {return}
                self.navigateViewController(context)
            }
            return
        }
        
        switch context.type {
        case .push:
            guard let fromViewController = context.fromVC else {break}
            guard let toViewController = context.toVC else {break}
            if let navi = fromViewController as? UINavigationController {
                // prevent crash when tried to push a certain Navigation Controller, or push a pushed vc
                guard toViewController.navigationController == nil, !(toViewController.self is UINavigationController) else {break}
                navi.pushViewController(toViewController, animated: context.animated)
            } else {
                fromViewController.show(toViewController, sender: nil)
            }
            guard context.animated else {break}
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
                context.completion?()
            }
            
        case let .present(type):
            guard let fromViewController = context.fromVC else {
                context.errorCompletion?(.none)
                break
            }
            guard let toViewController = context.toVC else {
                context.errorCompletion?(.none)
                break
            }
            // prevent crash when tried to prensent a presented vc
            guard toViewController.presentingViewController == nil else {
                context.errorCompletion?(.none)
                break
            }
            toViewController.modalPresentationStyle = type
            fromViewController.present(toViewController, animated: context.animated, completion: context.completion)
            
        case .pop:
            var _navi: UINavigationController?
            if let nv = context.fromVC as? UINavigationController {
                _navi = nv
            } else if let nv = context.fromVC?.navigationController {
                _navi = nv
            }
            guard let navi = _navi else {break}
            if let toVC = context.toVC {
                navi.popToViewController(toVC, animated: context.animated)
            } else {
                navi.popViewController(animated: context.animated)
            }
            guard context.animated else {break}
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
                context.completion?()
            }
            
        case .popToRoot:
            guard let navi = context.fromVC as? UINavigationController else {break}
            navi.popToRootViewController(animated: context.animated)
            guard context.animated else {break}
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
                context.completion?()
            }
            
        case .dismiss:
            guard let fromViewController = context.fromVC else {break}
            (fromViewController.navigationController ?? fromViewController)?.dismiss(animated: context.animated, completion: context.completion)
            
        default:
            break
        }
    }
}

enum NavigationType {
    case push
    case present(UIModalPresentationStyle)
    case pop
    case popToRoot
    case dismiss
    case unknown
}

// Should enhance to catch navigation errors
enum NavigationError: Error {
    case none
}

final class NavigationContext {
    var fromVC: UIViewController?
    var toVC: UIViewController?
    var type = NavigationType.unknown
    var animated = true
    var afterSec = 0.0
    var data: Any?
    var afterSecondsCompletion: (() -> Void)?
    var completion: (() -> Void)?
    var prepareData: ((NavigationContext) -> Void)?
    var errorCompletion: ((NavigationError) -> Void)?
    
    @discardableResult
    func completion(_ compl: (() -> Void)?) -> NavigationContext {
        completion = compl
        return self
    }
    
    @discardableResult
    func errorCompletion(_ compl: ((NavigationError) -> Void)?) -> NavigationContext {
        errorCompletion = compl
        return self
    }
    
    @discardableResult
    func prepareData(_ prepare: ((NavigationContext) -> Void)?) -> NavigationContext {
        prepareData = prepare
        return self
    }
    
    @discardableResult
    func data(_ d: Any?) -> NavigationContext {
        data = d
        return self
    }
    
    @discardableResult
    func animated(_ animate: Bool) -> NavigationContext {
        animated = animate
        return self
    }
    
    @discardableResult
    func afterSec(_ sec: Double) -> NavigationContext {
        afterSec = sec
        return self
    }
    
    @discardableResult
    func toVC(_ vc: UIViewController?) -> NavigationContext {
        toVC = vc
        return self
    }
    
    @discardableResult
    func fromVC(_ vc: UIViewController?) -> NavigationContext {
        fromVC = vc
        return self
    }
    
    @discardableResult
    func type(_ t: NavigationType) -> NavigationContext {
        type = t
        return self
    }
    
    deinit {
//        print("NavigationViewControllerContext deinit")
    }
}

extension AppMainNavigator {
    func showProfileViewController(_ context: NavigationContext) {
        let vc = UIViewController.make(UserInfoBasViewController.self)
        showVC(context.toVC(vc))
    }
}
