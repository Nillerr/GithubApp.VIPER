//
//  RepositoryModule.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

struct RepositoryModule {
    
    let presenterFactory: RepositoryPresenterFactory
    
    func present(_ repository: RepositoryListItem, in presentationSource: RepositoryPresentationSource) {
        // View
        let viewController = RepositoryViewController()
        
        // Connections
        viewController.viewDelegate = presenterFactory.presenter(for: repository, presenting: viewController, in: presentationSource)
        
        // View: Present
        presentationSource.present(viewController, title: repository.fullName)
    }
    
}
