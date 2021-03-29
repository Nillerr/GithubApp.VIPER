//
//  RepositoryPresenter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

protocol RepositoryView: AnyObject {
    func setRepository(_ repository: RepositoryListItem)
}

protocol RepositoryPresenterProtocol {
    func repositoryDidLoad(_ repository: RepositoryListItem)
}

class RepositoryPresenter: RepositoryPresenterProtocol {
    
    weak var view: RepositoryView!
    
    init(view: RepositoryView) {
        self.view = view
    }
    
    func repositoryDidLoad(_ repository: RepositoryListItem) {
        view.setRepository(repository)
    }
    
    deinit {
        print("[RepositoryPresenter] deinit")
    }
}
