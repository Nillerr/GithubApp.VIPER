//
//  RepositoryPresenterFactory.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation

struct RepositoryModuleComponents {
    
    func interactor(for repository: RepositoryListItem, presenting view: RepositoryView) -> RepositoryInteractorProtocol {
        // Presenter
        let presenter = RepositoryPresenter(view: view)
        
        // Interactor
        let interactor = RepositoryInteractor(repository: repository, presenter: presenter)
        
        return interactor
    }
    
    func router(in presentingSource: DismissableSource) -> RepositoryRouterProtocol {
        // Router
        let router = RepositoryRouter(presentingSource: presentingSource)
        
        return router
    }
    
}
