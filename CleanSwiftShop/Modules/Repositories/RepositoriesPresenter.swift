//
//  RepositoriesPresenter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation

protocol RepositoriesView: AnyObject {
    func setItems(_ items: [RepositoryListItem])
    func setLoading(_ loading: Bool)
}

protocol RepositoriesPresenterProtocol: AnyObject {
    func repositoriesWillLoad()
    func repositoriesDidLoad(_ repositories: [RepositoryListItem])
}

class RepositoriesPresenter: RepositoriesPresenterProtocol {
    
    weak var view: RepositoriesView?
    
    init(view: RepositoriesView) {
        self.view = view
    }
    
    func repositoriesWillLoad() {
        view?.setLoading(true)
    }
    
    func repositoriesDidLoad(_ repositories: [RepositoryListItem]) {
        view?.setItems(repositories)
        view?.setLoading(false)
    }
    
    deinit {
        print("[RepositoriesPresenter] deinit")
    }
    
}
