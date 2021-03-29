//
//  RepositoryPresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import UIKit

protocol RepositoryPresentationPresenter {
    func present(_ viewController: UIViewController, title: String)
}

protocol RepositoryPresentationDismisser {
    func dismiss()
}

protocol RepositoryPresentationSource: RepositoryPresentationPresenter, RepositoryPresentationDismisser {
}

/**
 Provides type erasure for an underlying presentation source, enabling easy swapping of `ModalPresentationSource` and `NavigationPresentationSource`. This type exists merely to prove a concept.
 */
struct AnyRepositoryPresentationSource: RepositoryPresentationSource {
    
    private let _present: (UIViewController, String) -> Void
    private let _dismiss: () -> Void
    
    init<S : ModalPresentationSource>(_ presentationSource: S) {
        self._present = presentationSource.present(_:title:)
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
    return (viewController, AnyRepositoryPresentationSource(presentationSource))
}

func navigationPresentation(_ viewController: UIViewController, title: String) -> (UIViewController, RepositoryPresentationSource) {
    viewController.navigationItem.title = title
    
    let navigationController = UINavigationController(rootViewController: viewController)
    let presentationSource = UINavigationControllerPresentationSource(navigationController: navigationController)
    
    return (navigationController, AnyRepositoryPresentationSource(presentationSource))
}
