//
//  RepositoryPresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import UIKit

protocol RepositoryPresentationSourceFactory {
    func presentationSource(_ repository: RepositoryListItem, from router: RepositoriesRouterProtocol) -> DismissablePresentationSource
    func dismiss()
}

struct ModalRepositoriesPresentationSourceFactory: RepositoryPresentationSourceFactory {
    
    let presentingViewController: UIViewController
    
    func presentationSource(_ repository: RepositoryListItem, from router: RepositoriesRouterProtocol) -> DismissablePresentationSource {
        return ModalViewControllerPresentationSource(presentingViewController: presentingViewController, title: repository.fullName)
    }
    
    func dismiss() {
        presentingViewController.dismiss(animated: true)
    }
}

struct UINavigationRepositoriesPresentationSourceFactory: RepositoryPresentationSourceFactory {
    
    let navigationController: UINavigationController
    
    func presentationSource(_ repository: RepositoryListItem, from router: RepositoriesRouterProtocol) -> DismissablePresentationSource {
        let rightBarButton = BarButton(title: "Close", action: router.dismiss)
        return UINavigationPresentationSource(navigationController: navigationController, title: repository.fullName, rightBarButton: rightBarButton)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
}

func repositoriesPresentation(for viewController: UIViewController, title: String, style: RepositoriesPresentationStyle) -> (UIViewController, RepositoryPresentationSourceFactory) {
    switch style {
    case .modal:
        return modalPresentation(viewController)
    case .navigation:
        return navigationPresentation(viewController, title: title)
    }
}

func modalPresentation(_ viewController: UIViewController) -> (UIViewController, RepositoryPresentationSourceFactory) {
    let presentationSource = ModalRepositoriesPresentationSourceFactory(presentingViewController: viewController)
    return (viewController, presentationSource)
}

func navigationPresentation(_ viewController: UIViewController, title: String) -> (UIViewController, RepositoryPresentationSourceFactory) {
    viewController.navigationItem.title = title
    
    let navigationController = UINavigationController(rootViewController: viewController)
    let presentationSource = UINavigationRepositoriesPresentationSourceFactory(navigationController: navigationController)
    
    return (navigationController, presentationSource)
}
