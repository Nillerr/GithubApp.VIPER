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

protocol RepositoryViewDelegate {
    func viewDidLoad()
}

class RepositoryPresenter: RepositoryViewDelegate {
    
    weak var view: RepositoryView!
    
    let router: RepositoryRouter
    let repository: RepositoryListItem
    
    init(view: RepositoryView, router: RepositoryRouter, repository: RepositoryListItem) {
        self.view = view
        self.router = router
        self.repository = repository
    }
    
    func viewDidLoad() {
        view.setRepository(repository)
    }
    
    deinit {
        print("[RepositoryPresenter] deinit")
    }
}
