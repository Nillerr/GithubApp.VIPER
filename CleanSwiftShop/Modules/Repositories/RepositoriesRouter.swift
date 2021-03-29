//
//  RepositoriesRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation

class RepositoriesRouter {

    let modulePresentationSource: RepositoryPresentationSource
    let repositoryModule: RepositoryModule
    
    init(modulePresentationSource: RepositoryPresentationSource, repositoryModule: RepositoryModule) {
        self.modulePresentationSource = modulePresentationSource
        self.repositoryModule = repositoryModule
    }
    
    func navigateToRepository(_ repository: RepositoryListItem) {
        repositoryModule.present(repository, in: modulePresentationSource)
    }
    
}
