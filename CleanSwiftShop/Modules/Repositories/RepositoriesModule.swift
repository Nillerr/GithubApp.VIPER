//
//  RepositoriesModule.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit
import Moya

enum RepositoriesPresentationStyle {
    case modal
    case navigation
}

/**
 - Modules are instantiated by other modules when they are presented.
 - Modules will typically depend on UIKit
 - Modules are not meant to be testable.
 - Modules wire together the View, Interactor, Presenter, Entities & Router of a Module, and present a `UIViewController` in a given Presentation Source.
 */
struct RepositoriesModule {
    
    let components: RepositoriesModuleComponents
    
    func present(_ presentationStyle: RepositoriesPresentationStyle, title: String, in presentationSource: PresentationSource) {
        // View
        let viewController = RepositoriesViewController()
        
        let (moduleViewController, modulePresentationSource) = repositoriesPresentation(for: viewController, title: title, style: presentationStyle)
        
        viewController.interactor = components.interactor(presenting: viewController)
        viewController.router = components.router(presentingModulesIn: modulePresentationSource)
        
        presentationSource.present(moduleViewController)
    }
    
}
