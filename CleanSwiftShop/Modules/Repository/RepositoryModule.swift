//
//  RepositoryModule.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

struct RepositoryModule {
    
    let components: RepositoryModuleComponents
    
    func present(_ repository: RepositoryListItem, in presentationSource: DismissablePresentationSource) {
        // View
        let viewController = RepositoryViewController()
        
        // Connections
        viewController.interactor = components.interactor(for: repository, presenting: viewController)
        viewController.router = components.router(in: presentationSource)
        
        // View: Present
        presentationSource.present(viewController)
    }
    
}
