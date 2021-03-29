//
//  RepositoriesModule.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit
import Moya

enum RepositoriesPresentationStyle {
    case modal
    case navigation
}

/**
 - Modules are instantiated by other modules when they are presented.
 - Modules will typically depend on UIKit
 - Modules are not meant to be testable.
 - Modules wire together the View, Interactor, Presenter, Entities & Router of a Module, and present a `UIViewController` in a given Presentation Source.
 */
struct RepositoriesModule {
    
    let github: MoyaProvider<Github>
    let repository: RepositoryModule
    
    func modal() -> UIViewController {
        // View
        let viewController = RepositoriesViewController()
        
        // Presenter
        let presenter = RepositoriesPresenter(view: viewController)
        
        // Interactor
        viewController.interactor = RepositoriesInteractor(presenter: presenter, github: github)
        viewController.router = ModalRepositoriesRouter(presentingViewController: viewController, repositoryModule: repository)
        
        return viewController
    }
    
    func navigation(title: String) -> UIViewController {
        // View
        let viewController = RepositoriesViewController()
        viewController.navigationItem.title = title
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // Presenter
        let presenter = RepositoriesPresenter(view: viewController)
        
        // Interactor
        viewController.interactor = RepositoriesInteractor(presenter: presenter, github: github)
        viewController.router = NavigationRepositoriesRouter(navigationController: navigationController, repositoryModule: repository)
        
        return navigationController
    }
    
}
