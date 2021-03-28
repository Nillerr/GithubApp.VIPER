//
//  RepositoriesInteractor.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import Moya

protocol RepositoriesInteractorDelegate: AnyObject {
    func repositoriesWillLoad()
    func repositoriesDidLoad(_ repositories: [RepositoryListItem])
}

class RepositoriesInteractor: AnyRepositoriesInteractor {
    
    weak var delegate: RepositoriesInteractorDelegate?
    
    private let github: MoyaProvider<Github>
    
    private var _refreshRepositoriesCancellable: Cancellable?
    
    init(github: MoyaProvider<Github>) {
        self.github = github
    }
    
    func refreshRepositories() {
        _refreshRepositoriesCancellable?.cancel()
        
        delegate?.repositoriesWillLoad()
        
        _refreshRepositoriesCancellable = github.request(.repositories) { [weak delegate] result in
            switch result {
            case .success(let response):
                if let repositories = try? JSONDecoder().decode([RepositoryListItem].self, from: response.data) {
                    delegate?.repositoriesDidLoad(repositories)
                }
            case .failure(let error):
                print("MoyaError: \(error)")
            }
        }
    }
}
