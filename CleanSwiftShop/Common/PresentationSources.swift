//
//  PresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

protocol Presentable {
    func present()
}

protocol PresentationSource {
    func present(_ viewController: UIViewController)
}

protocol DismissableSource {
    func dismiss()
}

protocol DismissablePresentationSource: PresentationSource, DismissableSource {
}

/**
 Presents a `UIViewController` as a tab of a `UITabBarController`
 */
struct UITabPresentationSource: PresentationSource {
    
    let tabBarController: UITabBarController
    let title: String?
    let image: UIImage?
    
    func present(_ viewController: UIViewController) {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers.append(viewController)
        
        tabBarController.viewControllers = viewControllers
    }
    
}

/**
 Presents a `UIViewController` as a modal of another `UIViewController`
 */
struct UIModalPresentationSource: DismissablePresentationSource {
    
    let presentingViewController: UIViewController
    
    func present(_ viewController: UIViewController) {
        presentingViewController.present(viewController, animated: true)
    }
    
    func dismiss() {
        presentingViewController.dismiss(animated: true)
    }
    
}

/**
 Presents a `UIViewController` as the root of a `UIWindow`
 */
struct UIWindowPresentationSource: PresentationSource {
    
    let window: UIWindow
    
    func present(_ viewController: UIViewController) {
        window.rootViewController = viewController
    }
    
}

@objc class BarButton: NSObject {
    
    let title: String?
    let action: (() -> Void)?
    
    init(title: String? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
    }
    
    @objc internal func invokeAction() {
        action?()
    }
    
    deinit {
        print("[BarButton] deinit")
    }
}

/**
 Presents a `UIViewController` + `Navigation` in a navigation stack
 */
struct UINavigationPresentationSource: DismissablePresentationSource {
   
    let navigationController: UINavigationController
    let title: String?
    let rightBarButton: BarButton?
    
    func present(_ viewController: UIViewController) {
        viewController.navigationItem.title = title
        
        if let rightBarButton = rightBarButton {
            let button = UIBarButtonItem(
                title: rightBarButton.title,
                style: .plain,
                target: rightBarButton,
                action: #selector(rightBarButton.invokeAction)
            )
            
            viewController.navigationItem.rightBarButtonItem = button
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
}
