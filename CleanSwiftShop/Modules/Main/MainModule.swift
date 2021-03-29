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
    
    let presenterFactory: MainPresenterFactory
    
    func present(in presentationSource: WindowPresentationSource) {
        // View
        let viewController = MainViewController()
        
        // View: TabBar Presentation Source
        let modulePresentationSource = UITabBarControllerPresentationSource(tabBarController: viewController)
        
        // Connections
        viewController.viewDelegate = presenterFactory.presenter(presenting: viewController, presentingModulesIn: modulePresentationSource)
        
        // View: Present Module
        presentationSource.setRootViewController(viewController)
    }
    
}
