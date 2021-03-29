//
//  MainPresenter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

protocol MainView: AnyObject {
}

protocol MainViewDelegate {
}

class MainPresenter: MainViewDelegate {
    
    weak var view: MainView!
    
    let router: MainRouter
    
    init(view: MainView, router: MainRouter) {
        self.view = view
        self.router = router
    }
}
