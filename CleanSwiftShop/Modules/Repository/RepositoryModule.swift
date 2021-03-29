//
//  RepositoryModule.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

struct RepositoryModule {
    
    func create(_ repository: RepositoryListItem, pushedTo navigationController: UINavigationController) -> UIViewController {
        // View
        let viewController = RepositoryViewController()
        
        // Connections
        viewController.interactor = interactor(for: repository, presenting: viewController)
        viewController.router = RepositoryRouter(navigationController: navigationController)
        
        // View: Present
        return viewController
    }
    
    func create(_ repository: RepositoryListItem, presentedIn presentingViewController: UIViewController) -> UIViewController {
        // View
        let viewController = RepositoryViewController()
        
        // Connections
        viewController.interactor = interactor(for: repository, presenting: viewController)
        viewController.router = RepositoryRouter(viewController: presentingViewController)
        
        // View: Present
        return viewController
    }
    
    private func interactor(for repository: RepositoryListItem, presenting view: RepositoryView) -> RepositoryInteractor {
        // Presenter
        let presenter = RepositoryPresenter(view: view)
        
        // Interactor
        let interactor = RepositoryInteractor(repository: repository, presenter: presenter)
        
        return interactor
    }
    
}
