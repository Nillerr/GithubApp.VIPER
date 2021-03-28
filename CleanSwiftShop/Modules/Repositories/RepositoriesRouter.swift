//
//  RepositoriesRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation

class RepositoriesRouter: AnyRepositoriesRouter {

    let presentationSource: RepositoryPresentationSource
    
    let repositoryModule: RepositoryModule
    
    init(presentationSource: @escaping RepositoryPresentationSource, repositoryModule: RepositoryModule) {
        self.presentationSource = presentationSource
        self.repositoryModule = repositoryModule
    }
    
    func navigateToRepository(_ repository: RepositoryListItem) {
        repositoryModule.present(repository, in: presentationSource)
    }
    
}
