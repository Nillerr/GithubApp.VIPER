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
    func presentation(of viewController: UIViewController) -> Presentable & Dismissable
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
    func presentation(of viewController: UIViewController, navigation: Navigation) -> Presentable & Dismissable
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
    
    weak var viewController: UIViewController?
    
    func present() {
        if let viewController = viewController {
            window.rootViewController = viewController
        } else {
            print("[WARN] Attempt to present a UIWindowPresentation multiple times. Create a new Presentation using a Presentation Source to present the view controller again.")
        }
    }
}

/**
 Creates `ModalPresentation` presentations that presents a `UIViewController` as a modal in a presenting `UIViewController`.
 */
struct UIViewControllerPresentationSource: ViewPresentationSource {
    
    let presentingViewController: UIViewController
    
    func presentation(of viewController: UIViewController) -> Dismissable & Presentable {
        return UIViewControllerPresentation(presentingViewController: presentingViewController, viewController: viewController)
    }
}

struct UIViewControllerPresentation: Presentable, Dismissable {
    
    let presentingViewController: UIViewController
    
    weak var viewController: UIViewController?
    
    func present() {
        if let viewController = viewController {
            presentingViewController.present(viewController, animated: true)
        } else {
            print("[WARN] Attempt to present a UIViewControllerPresentation multiple times. Create a new Presentation using a Presentation Source to present the view controller again.")
        }
    }
    
    func dismiss() {
        presentingViewController.dismiss(animated: true)
    }
}

/**
 Creates `NavigationPresentation` presentations that push a `UIViewController` to a `UINavigationController`.
 */
struct UINavigationControllerPresentationSource: NavigationPresentationSource {
    
    let navigationController: UINavigationController
    
    func presentation(of viewController: UIViewController, navigation: Navigation) -> Dismissable & Presentable {
        return UINavigationControllerPresentation(navigationController: navigationController, navigation: navigation, viewController: viewController)
    }
}

/**
 Creates `NavigationPresentation` presentations that push a `UIViewController` with a specific `title` to a `UINavigationController`.
 */
struct ConfiguredNavigationPresentationSource: ViewPresentationSource {
    
    let presentationSource: UINavigationControllerPresentationSource
    let navigation: Navigation
    
    func presentation(of viewController: UIViewController) -> Dismissable & Presentable {
        return presentationSource.presentation(of: viewController, navigation: navigation)
    }
    
}

struct UINavigationControllerPresentation: Presentable, Dismissable {
    
    let navigationController: UINavigationController
    let navigation: Navigation
    
    weak var viewController: UIViewController?
    
    func present() {
        if let viewController = viewController {
            viewController.navigationItem.title = navigation.title
            viewController.navigationItem.backButtonTitle = navigation.backButtonTitle
            
            navigationController.pushViewController(viewController, animated: true)
        } else {
            print("[WARN] Attempt to present a UINavigationControllerPresentation multiple times. Create a new Presentation using a Presentation Source to present the view controller again.")
        }
    }
    
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
    
    weak var viewController: UIViewController?
    
    func present() {
        if let viewController = viewController {
            viewController.tabBarItem.title = tab.title
            viewController.tabBarItem.image = tab.image
            
            var viewControllers = tabBarController.viewControllers ?? []
            viewControllers.append(viewController)
            
            tabBarController.viewControllers = viewControllers
        } else {
            print("[WARN] Attempt to present a UITabBarPresentation multiple times. Create a new Presentation using a Presentation Source to present the view controller again.")
        }
    }
}

