//
//  RepositoryModule.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

struct RepositoryModule {
    
    func present(_ repository: RepositoryListItem, in presentationSource: RepositoryPresentationSource) {
        // View
        let viewController = RepositoryViewController()
        
        // View: Create Presentation
        let presentation = presentationSource(viewController, repository.fullName)
        
        // Router
        let router = RepositoryRouter(presentation: presentation)
        
        // Presenter
        let presenter = RepositoryPresenter(view: viewController, router: router, repository: repository)
        
        // Connections
        viewController.viewDelegate = presenter
        
        // View: Present
        presentation.present()
    }
    
}
