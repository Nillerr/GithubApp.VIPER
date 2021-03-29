//
//  MainRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

struct MainRouter {
    
    init(modulePresentationSource: TabBarPresentationSource, repositories: RepositoriesModule) {
        // View: Tab: Repositories (Modal)
        repositories.present(.modal, title: "Repos (Modal)", in: modulePresentationSource)
        
        // View: Tab: Repositories (Navigation)
        repositories.present(.navigation, title: "Repos (Navigation)", in: modulePresentationSource)
    }
    
}
