//
//  RepositoriesRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import UIKit

protocol RepositoriesRouterProtocol: AnyObject {
    func navigateToRepository(_ repository: RepositoryListItem)
    func dismiss()
}

class RepositoriesRouter: RepositoriesRouterProtocol {

    let presentationSourceFactory: RepositoryPresentationSourceFactory
    let repositoryModule: RepositoryModule
    
    init(modulePresentationSource: RepositoryPresentationSourceFactory, repositoryModule: RepositoryModule) {
        self.presentationSourceFactory = modulePresentationSource
        self.repositoryModule = repositoryModule
    }
    
    func navigateToRepository(_ repository: RepositoryListItem) {
        let presentationSource = presentationSourceFactory.presentationSource(repository, from: self)
        repositoryModule.present(repository, in: presentationSource)
    }
    
    @objc func dismiss() {
        presentationSourceFactory.dismiss()
    }
    
}
