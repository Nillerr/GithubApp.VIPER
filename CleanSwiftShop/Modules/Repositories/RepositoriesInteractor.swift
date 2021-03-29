//
//  RepositoriesInteractor.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import Moya

protocol RepositoriesInteractorProtocol: AnyObject {
    func refreshRepositories()
}

class RepositoriesInteractor: RepositoriesInteractorProtocol {
    
    let presenter: RepositoriesPresenterProtocol
    let github: MoyaProvider<Github>
    
    init(presenter: RepositoriesPresenterProtocol, github: MoyaProvider<Github>) {
        self.presenter = presenter
        self.github = github
    }
    
    private var _refreshRepositoriesCancellable: Cancellable?
    
    func refreshRepositories() {
        _refreshRepositoriesCancellable?.cancel()
        
        presenter.repositoriesWillLoad()
        
        _refreshRepositoriesCancellable = github.request(.repositories) { [weak presenter] result in
            switch result {
            case .success(let response):
                if let repositories = try? JSONDecoder().decode([RepositoryListItem].self, from: response.data) {
                    presenter?.repositoriesDidLoad(repositories)
                }
            case .failure(let error):
                print("MoyaError: \(error)")
            }
        }
    }
}
