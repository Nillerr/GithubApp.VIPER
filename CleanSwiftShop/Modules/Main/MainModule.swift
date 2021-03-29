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
    
    func create() -> UIViewController {
        // View
        let tabBarController = UITabBarController()
        
        // View: Tab: Repositories (Modal)
        addTab(for: repositories.modal(), in: tabBarController, title: "Repos (Modal)", image: UIImage(systemName: "macwindow.on.rectangle"))
        
        // View: Tab: Repositories (Navigation)
        addTab(for: repositories.navigation(title: "Repositories"), in: tabBarController, title: "Repos (Navigation)", image: UIImage(systemName: "arrow.right.doc.on.clipboard"))
        
        return tabBarController
    }
    
    private func addTab(for viewController: UIViewController, in tabBarController: UITabBarController, title: String, image: UIImage?) {
        var viewControllers = tabBarController.viewControllers ?? []
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        viewControllers.append(viewController)
        
        tabBarController.viewControllers = viewControllers
    }
    
}
