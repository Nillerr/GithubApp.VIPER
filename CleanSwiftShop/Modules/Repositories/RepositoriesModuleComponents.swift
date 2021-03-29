//
//  RepositoriesPresenterFactory.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import Moya

struct RepositoriesModuleComponents {
    
    let github: MoyaProvider<Github>
    let repository: RepositoryModule
    
    func interactor(presenting view: RepositoriesView) -> RepositoriesInteractorProtocol {
        // Presenter
        let presenter = RepositoriesPresenter(view: view)
        
        // Interactor
        let interactor = RepositoriesInteractor(presenter: presenter, github: github)
        
        return interactor
    }
    
    func router(presentingModulesIn modulePresentationSource: RepositoryPresentationSourceFactory) -> RepositoriesRouterProtocol {
        // Router
        let router = RepositoriesRouter(
            modulePresentationSource: modulePresentationSource,
            repositoryModule: repository
        )
        
        return router
    }
}
