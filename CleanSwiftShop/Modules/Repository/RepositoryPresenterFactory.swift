//
//  RepositoryPresenterFactory.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation

struct RepositoryPresenterFactory {
    
    func presenter(for repository: RepositoryListItem, presenting view: RepositoryView, in presentingSource: RepositoryPresentationDismisser) -> RepositoryPresenter {
        // Router
        let router = RepositoryRouter(presentingSource: presentingSource)
        
        // Presenter
        let presenter = RepositoryPresenter(view: view, router: router, repository: repository)
        
        return presenter
    }
    
}
