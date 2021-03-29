//
//  PresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

/**
 Presents a `UIViewController` as the root of a window
 */
protocol WindowPresentationSource {
    func setRootViewController(_ viewController: UIViewController)
}

/**
 Dismisses a presented view controller
 */
protocol ModalPresentationDismisser {
    func dismiss()
}

/**
 Presents a `UIViewController` as a modal
 */
protocol ModalPresentationPresenter {
    func present(_ viewController: UIViewController)
}

protocol ModalPresentationSource: ModalPresentationPresenter, ModalPresentationDismisser {
}

/**
 Dismisses the top of a navigation stack
 */
protocol NavigationPresentationDismisser {
    func pop()
}

/**
 Presents a `UIViewController` + `Navigation` in a navigation stack
 */
protocol NavigationPresentationPresenter {
    func push(_ viewController: UIViewController, navigation: Navigation)
}

protocol NavigationPresentationSource: NavigationPresentationPresenter, NavigationPresentationDismisser {
}

struct Navigation {
    let title: String?
    let backButtonTitle: String?
    
    init(title: String? = nil, backButtonTitle: String? = nil) {
        self.title = title
        self.backButtonTitle = backButtonTitle
    }
}

/**
 Presents a `UIViewController` + `Tab` as a tab in a tab bar
 */
protocol TabBarPresentationSource {
    func addTab(_ viewController: UIViewController, tab: Tab)
}

struct Tab {
    let title: String?
    let image: UIImage?
    
    init(title: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
}

/**
 Presents a `UIViewController` by setting it as the `rootViewController` of a `UIWindow`.
 */
struct UIWindowPresentationSource: WindowPresentationSource {
    
    let window: UIWindow
    
    func setRootViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
    }
}

/**
 Presents a `UIViewController` as a modal in a presenting `UIViewController`.
 */
struct UIViewControllerPresentationSource: ModalPresentationSource {
    
    let presentingViewController: UIViewController
    
    func present(_ viewController: UIViewController) {
        presentingViewController.present(viewController, animated: true)
    }
    
    func dismiss() {
        presentingViewController.dismiss(animated: true)
    }
}

/**
 Pushes a `UIViewController` to a `UINavigationController`.
 */
struct UINavigationControllerPresentationSource: NavigationPresentationSource {
    
    let navigationController: UINavigationController
    
    func push(_ viewController: UIViewController, navigation: Navigation) {
        viewController.navigationItem.title = navigation.title
        viewController.navigationItem.backButtonTitle = navigation.backButtonTitle
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}

/**
 Adds a `UIViewController` as a tab to a `UITabBarController`.
 */
struct UITabBarControllerPresentationSource: TabBarPresentationSource {
    
    let tabBarController: UITabBarController
    
    func addTab(_ viewController: UIViewController, tab: Tab) {
        viewController.tabBarItem.title = tab.title
        viewController.tabBarItem.image = tab.image
        
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers.append(viewController)
        
        tabBarController.viewControllers = viewControllers
    }
    
}
