//
//  RepositoryInteractor.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation

protocol RepositoryInteractorProtocol {
    func loadRepository()
}

class RepositoryInteractor: RepositoryInteractorProtocol {
    
    let repository: RepositoryListItem
    let presenter: RepositoryPresenterProtocol
    
    init(repository: RepositoryListItem, presenter: RepositoryPresenterProtocol) {
        self.repository = repository
        self.presenter = presenter
    }
    
    func loadRepository() {
        presenter.repositoryDidLoad(repository)
    }
    
}
