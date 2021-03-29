//
//  RepositoryRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

protocol RepositoryRouterProtocol: AnyObject {
    func dismiss()
}

class RepositoryRouter: RepositoryRouterProtocol {
    
    let presentingSource: DismissableSource
    
    init(presentingSource: DismissableSource) {
        self.presentingSource = presentingSource
    }
    
    func dismiss() {
        presentingSource.dismiss()
    }
    
    deinit {
        print("[RepositoryRouter] deinit")
    }
}
