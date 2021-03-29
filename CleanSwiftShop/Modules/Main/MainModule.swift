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
    
    func present(in presentationSource: WindowPresentationSource) {
        // View
        let viewController = MainViewController()
        
        // View: TabBar Presentation Source
        let tabBarPresentationSource = UITabBarControllerPresentationSource(tabBarController: viewController)
        
        // View: Tab: Repositories (Modal)
        repositories.present(.modal, title: "Repos (Modal)", in: tabBarPresentationSource)
        
        // View: Tab: Repositories (Navigation)
        repositories.present(.navigation, title: "Repos (Navigation)", in: tabBarPresentationSource)
        
        // Presenter
        let presenter = MainPresenter(view: viewController)
        
        // Connections
        viewController.viewDelegate = presenter
        
        // View: Present Module
        presentationSource.setRootViewController(viewController)
    }
    
}
