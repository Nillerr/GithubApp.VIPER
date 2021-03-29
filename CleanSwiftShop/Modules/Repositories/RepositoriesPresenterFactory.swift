//
//  RepositoriesPresenterFactory.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import Moya

struct RepositoriesPresenterFactory {
    
    let github: MoyaProvider<Github>
    let repository: RepositoryModule
    
    func presenter(presenting view: RepositoriesView, presentingModulesIn modulePresentationSource: RepositoryPresentationSource) -> RepositoriesPresenter {
        // Interactor
        let interactor = RepositoriesInteractor(github: github)
        
        // Router
        let router = RepositoriesRouter(
            modulePresentationSource: modulePresentationSource,
            repositoryModule: repository
        )
        
        // Presenter
        let presenter = RepositoriesPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        // Connections
        interactor.delegate = presenter
        
        return presenter
    }
}
