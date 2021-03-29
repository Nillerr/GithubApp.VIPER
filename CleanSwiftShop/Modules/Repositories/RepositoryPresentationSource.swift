//
//  RepositoryPresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import UIKit

/**
 Provides type erasure for an underlying presentation source, enabling easy swapping of `ModalPresentationSource` and `NavigationPresentationSource`. This type exists merely to prove a concept.
 */
struct RepositoryPresentationSource {
    
    private let _present: (UIViewController, String) -> Void
    private let _dismiss: () -> Void
    
    init<S : ModalPresentationSource>(_ presentationSource: S) {
        self._present = { viewController, title in presentationSource.present(viewController) }
        self._dismiss = presentationSource.dismiss
    }
    
    init<S : NavigationPresentationSource>(_ presentationSource: S) {
        self._present = { viewController, title in presentationSource.push(viewController, navigation: Navigation(title: title)) }
        self._dismiss = presentationSource.pop
    }
    
    func present(_ viewController: UIViewController, title: String) {
        _present(viewController, title)
    }
    
    func dismiss() {
        _dismiss()
    }
}

func modalPresentation(_ viewController: UIViewController) -> (UIViewController, RepositoryPresentationSource) {
    let presentationSource = UIViewControllerPresentationSource(presentingViewController: viewController)
    return (viewController, RepositoryPresentationSource(presentationSource))
}

func navigationPresentation(_ viewController: UIViewController, title: String) -> (UIViewController, RepositoryPresentationSource) {
    viewController.navigationItem.title = title
    
    let navigationController = UINavigationController(rootViewController: viewController)
    let presentationSource = UINavigationControllerPresentationSource(navigationController: navigationController)
    
    return (navigationController, RepositoryPresentationSource(presentationSource))
}
