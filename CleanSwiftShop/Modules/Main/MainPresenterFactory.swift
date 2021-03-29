//
//  MainPresenterFactory.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation

struct MainPresenterFactory {
    
    let repositories: RepositoriesModule
    
    func presenter(presenting view: MainView, presentingModulesIn modulePresentationSource: TabBarPresentationSource) -> MainPresenter {
        // Router
        let router = MainRouter(modulePresentationSource: modulePresentationSource, repositories: repositories)
        
        // Presenter
        let presenter = MainPresenter(view: view, router: router)
        
        return presenter
    }
    
}
