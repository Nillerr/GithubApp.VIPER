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

protocol RepositoriesViewDelegate {
    func viewDidLoad()
    func didSelect(_ item: RepositoryListItem)
    func didRefresh()
}

class RepositoriesPresenter {
    
    weak var view: RepositoriesView?
    
    let interactor: RepositoriesInteractor
    let router: RepositoriesRouter
    
    init(view: RepositoriesView, interactor: RepositoriesInteractor, router: RepositoriesRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    deinit {
        print("[RepositoriesPresenter] deinit")
    }
    
}

extension RepositoriesPresenter: RepositoriesViewDelegate {
    
    func viewDidLoad() {
        interactor.refreshRepositories()
    }
    
    func didSelect(_ item: RepositoryListItem) {
        router.navigateToRepository(item)
    }
    
    func didRefresh() {
        interactor.refreshRepositories()
    }
    
}

extension RepositoriesPresenter: RepositoriesInteractorDelegate {
    
    func repositoriesWillLoad() {
        view?.setLoading(true)
    }
    
    func repositoriesDidLoad(_ repositories: [RepositoryListItem]) {
        view?.setItems(repositories)
        view?.setLoading(false)
    }
    
}
