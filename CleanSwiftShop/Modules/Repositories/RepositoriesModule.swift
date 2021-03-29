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
    
    let presenterFactory: RepositoriesPresenterFactory
    
    func present(_ presentationStyle: RepositoriesPresentationStyle, title: String, in presentationSource: TabBarPresentationSource) {
        // View
        let viewController = RepositoriesViewController()
        
        let (moduleViewController, modulePresentationSource) = presentationStyle == .modal
            ? modalPresentation(viewController)
            : navigationPresentation(viewController, title: title)
        
        // Interactor + Presenter + Router
        viewController.viewDelegate = presenterFactory.presenter(presenting: viewController, presentingModulesIn: modulePresentationSource)
        
        // View: Present Module
        let imageSystemName = presentationStyle == .modal ? "macwindow.on.rectangle" : "arrow.right.doc.on.clipboard"
        let image = UIImage(systemName: imageSystemName)
        let tab = Tab(title: title, image: image)
        presentationSource.addTab(moduleViewController, tab: tab)
    }
    
}
