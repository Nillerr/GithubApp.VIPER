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
 - Modules are not meant to be testable.
 - Modules wire together the View, Interactor, Presenter, Entities & Router of a Module, and present a `UIViewController` in a given Presentation Source.
 */
struct RepositoriesModule {
    
    private let github: MoyaProvider<Github>
    
    init(github: MoyaProvider<Github>) {
        self.github = github
    }
    
    func present(_ presentationStyle: RepositoriesPresentationStyle, title: String, in presentationSource: TabBarPresentationSource) {
        // View
        let viewController = RepositoriesViewController()
        
        let (moduleViewController, modulePresentationSource) = presentationStyle == .modal
            ? modalPresentation(viewController)
            : navigationPresentation(viewController, title: title)
        
        // View: Create presentation
        let imageSystemName = presentationStyle == .modal ? "macwindow.on.rectangle" : "arrow.right.doc.on.clipboard"
        let image = UIImage(systemName: imageSystemName)
        let tab = Tab(title: title, image: image)
        let presentable = presentationSource.presentation(of: moduleViewController, tab: tab)
        
        // Interactor
        let interactor = RepositoriesInteractor(github: github)
        
        // Router
        let repositoryModule = RepositoryModule()
        
        let router = RepositoriesRouter(
            presentationSource: modulePresentationSource,
            repositoryModule: repositoryModule
        )
        
        // Presenter
        let presenter = RepositoriesPresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )
        
        // Connections
        viewController.viewDelegate = presenter
        interactor.delegate = presenter
        
        // View: Present Module
        presentable.present()
    }
    
}

typealias RepositoryPresentationSource = (UIViewController, String) -> (Presentable, Dismissable)

func modalPresentation(_ viewController: UIViewController) -> (UIViewController, RepositoryPresentationSource) {
    let presentationSource = UIViewControllerPresentationSource(presentingViewController: viewController)
    return (
        viewController,
        { vc, title in presentationSource.presentation(of: vc) }
    )
}

func navigationPresentation(_ viewController: UIViewController, title: String) -> (UIViewController, RepositoryPresentationSource) {
    viewController.navigationItem.title = title
    
    let navigationController = UINavigationController(rootViewController: viewController)
    let presentationSource = UINavigationControllerPresentationSource(navigationController: navigationController)
    return (
        navigationController,
        { vc, title in presentationSource.presentation(of: vc, navigation: Navigation(title: title)) }
    )
}
