//
//  RepositoriesRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import UIKit

@objc class BarButtonAction: NSObject {
    
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    @objc func invokeAction() {
        action()
    }
    
}

protocol RepositoriesRouterProtocol: AnyObject {
    func navigateToRepository(_ repository: RepositoryListItem)
    func dismissRepository()
}

class ModalRepositoriesRouter: RepositoriesRouterProtocol {

    let presentingViewController: UIViewController
    let repository: RepositoryModule
    
    init(presentingViewController: UIViewController, repositoryModule: RepositoryModule) {
        self.presentingViewController = presentingViewController
        self.repository = repositoryModule
    }
    
    func navigateToRepository(_ repository: RepositoryListItem) {
        let viewController = self.repository.create(repository, presentedIn: presentingViewController)
        ModalViewController.present(viewController, title: repository.fullName, from: presentingViewController)
    }
    
    func dismissRepository() {
        presentingViewController.dismiss(animated: true)
    }
    
}

class NavigationRepositoriesRouter: RepositoriesRouterProtocol {
    
    private lazy var dismissAction: BarButtonAction = {
        return BarButtonAction { [weak self] in self?.dismissRepository() }
    }()
    
    let navigationController: UINavigationController
    let repositoryModule: RepositoryModule
    
    init(navigationController: UINavigationController, repositoryModule: RepositoryModule) {
        self.navigationController = navigationController
        self.repositoryModule = repositoryModule
    }
    
    func navigateToRepository(_ repository: RepositoryListItem) {
        let viewController = repositoryModule.create(repository, pushedTo: navigationController)
        
        viewController.navigationItem.title = repository.fullName
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: dismissAction, action: #selector(dismissAction.invokeAction))
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismissRepository() {
        navigationController.popViewController(animated: true)
    }
    
}
