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
    
    private let github: MoyaProvider<Github>
    
    init(github: MoyaProvider<Github>) {
        self.github = github
    }
    
    func present(in presentationSource: WindowPresentationSource) {
        // View
        let viewController = MainViewController()
        
        // View: Create presentation
        let presentation = presentationSource.presentation(of: viewController)
        
        // View: TabBar Presentation Source
        let tabBarPresentationSource = UITabBarControllerPresentationSource(tabBarController: viewController)
        
        let repositoriesModule = RepositoriesModule(github: github)
        
        // View: Tab: Repositories (Modal)
        repositoriesModule.present(.modal, title: "Repos (Modal)", in: tabBarPresentationSource)
        
        // View: Tab: Repositories (Navigation)
        repositoriesModule.present(.navigation, title: "Repos (Navigation)", in: tabBarPresentationSource)
        
        // Presenter
        let presenter = MainPresenter(view: viewController)
        
        // Connections
        viewController.viewDelegate = presenter
        
        // View: Present Module
        presentation.present()
    }
    
}
