//
//  PresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

/**
 Represents an a presentable presentation
 */
protocol Presentable {
    /**
     Presents the View of a module in the Presentation Source this Presentation was created with.
     
     - In a `UIWindow` this results in setting the value of the `rootViewController` property.
     - In a `UITabBarController` this results in adding the underlying `UIViewController` to the `viewControllers` property.
     - In a `UINavigationController` this results in a call to `pushViewController(_:animated:)`.
     - In a `UIViewController` this results in a call to `present(_:animated:)`
     */
    func present()
}

/**
 Represents a dismissable presentation.
 
 Not all presentations are dismissable, e.g. presentations in `UIWindow` and `UITabBarController`.
 */
protocol Dismissable {
    /**
     Dismisses the View of a module in the Presentation Source this Presentation was created with.
     
     - In a `UINavigationController` this results in a call to `popViewController(animated:)`.
     - In a `UIViewController` (modal) this results in a call to `dismiss(animated:)`.
     */
    func dismiss()
}

/**
 Creates a presentation for a `UIViewController` (modal).
 */
protocol ViewPresentationSource {
    func presentation(of viewController: UIViewController) -> (Presentable, Dismissable)
}

/**
 Creates a presentation for a `UIViewController` that's not dismissable, for use in presenting the main view of the application.
 */
protocol WindowPresentationSource {
    func presentation(of viewController: UIViewController) -> Presentable
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
 Creates a presentation for a `UIViewController` + `Navigation` for presentation in a navigation stack.
 */
protocol NavigationPresentationSource {
    func presentation(of viewController: UIViewController, navigation: Navigation) -> (Presentable, Dismissable)
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
 Creates a presentation for a `UIViewController` + `Tab` for presentation in a tab bar.
 */
protocol TabBarPresentationSource {
    func presentation(of viewController: UIViewController, tab: Tab) -> Presentable
}

/**
 Creates `UIWindowPresentation` presentations that sets a `UIViewController` as the `rootViewController` of a `UIWindow`.
 */
struct UIWindowPresentationSource: WindowPresentationSource {
    
    let window: UIWindow
    
    func presentation(of viewController: UIViewController) -> Presentable {
        return UIWindowPresentation(window: window, viewController: viewController)
    }
}

struct UIWindowPresentation: Presentable {
    
    let window: UIWindow
    
    let viewController: UIViewController
    
    func present() {
        window.rootViewController = viewController
    }
}

/**
 Creates `ModalPresentation` presentations that presents a `UIViewController` as a modal in a presenting `UIViewController`.
 */
struct UIViewControllerPresentationSource: ViewPresentationSource {
    
    let presentingViewController: UIViewController
    
    func presentation(of viewController: UIViewController) -> (Presentable, Dismissable) {
        let presentable = UIViewControllerPresentation(presentingViewController: presentingViewController, viewController: viewController)
        let dismissal = UIViewControllerDismissal(presentingViewController: presentingViewController)
        return (presentable, dismissal)
    }
}

struct UIViewControllerPresentation: Presentable {
    
    let presentingViewController: UIViewController
    
    let viewController: UIViewController
    
    func present() {
        presentingViewController.present(viewController, animated: true)
    }
}

struct UIViewControllerDismissal: Dismissable {
    
    let presentingViewController: UIViewController
    
    func dismiss() {
        presentingViewController.dismiss(animated: true)
    }
}

/**
 Creates `NavigationPresentation` presentations that push a `UIViewController` to a `UINavigationController`.
 */
struct UINavigationControllerPresentationSource: NavigationPresentationSource {
    
    let navigationController: UINavigationController
    
    func presentation(of viewController: UIViewController, navigation: Navigation) -> (Presentable, Dismissable) {
        let presentable = UINavigationControllerPresentation(navigationController: navigationController, navigation: navigation, viewController: viewController)
        let dismissable = UINavigationControllerDismissal(navigationController: navigationController)
        return (presentable, dismissable)
    }
}

/**
 Creates `NavigationPresentation` presentations that push a `UIViewController` with a specific `title` to a `UINavigationController`.
 */
struct ConfiguredNavigationPresentationSource: ViewPresentationSource {
    
    let presentationSource: UINavigationControllerPresentationSource
    let navigation: Navigation
    
    func presentation(of viewController: UIViewController) -> (Presentable, Dismissable) {
        return presentationSource.presentation(of: viewController, navigation: navigation)
    }
    
}

struct UINavigationControllerPresentation: Presentable {
    
    let navigationController: UINavigationController
    let navigation: Navigation
    
    let viewController: UIViewController
    
    func present() {
        viewController.navigationItem.title = navigation.title
        viewController.navigationItem.backButtonTitle = navigation.backButtonTitle
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

struct UINavigationControllerDismissal: Dismissable {
    
    let navigationController: UINavigationController
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}

/**
 Creates `TabBarPresentation` presentations that adds a `UIViewController` as a tab to a `UITabBarController`.
 */
struct UITabBarControllerPresentationSource: TabBarPresentationSource {
    
    let tabBarController: UITabBarController
    
    func presentation(of viewController: UIViewController, tab: Tab) -> Presentable {
        return UITabBarPresentation(tabBarController: tabBarController, tab: tab, viewController: viewController)
    }
}

struct UITabBarPresentation: Presentable {
    
    let tabBarController: UITabBarController
    let tab: Tab
    
    let viewController: UIViewController
    
    func present() {
        viewController.tabBarItem.title = tab.title
        viewController.tabBarItem.image = tab.image
        
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers.append(viewController)
        
        tabBarController.viewControllers = viewControllers
    }
}

