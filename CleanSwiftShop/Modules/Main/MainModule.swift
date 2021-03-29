//
//  MainModule.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit
import Moya

struct MainModule {
    
    let repositories: RepositoriesModule
    
    func present(in presentationSource: PresentationSource) {
        // View
        let tabBarController = UITabBarController()
        
        // View: Tab: Repositories (Modal)
        let modalTitle = "Repos (Modal)"
        let modalImage = UIImage(systemName: "macwindow.on.rectangle")
        let modalTab = UITabPresentationSource(tabBarController: tabBarController, title: modalTitle, image: modalImage)
        repositories.present(.modal, title: modalTitle, in: modalTab)
        
        // View: Tab: Repositories (Navigation)
        let navigationTitle = "Repos (Navigation)"
        let navigationImage = UIImage(systemName: "arrow.right.doc.on.clipboard")
        let navigationTab = UITabPresentationSource(tabBarController: tabBarController, title: navigationTitle, image: navigationImage)
        repositories.present(.navigation, title: navigationTitle, in: navigationTab)
        
        presentationSource.present(tabBarController)
    }
    
}
