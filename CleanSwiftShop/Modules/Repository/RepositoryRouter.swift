//
//  RepositoryRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

class RepositoryRouter {
    
    let presentingSource: RepositoryPresentationDismisser
    
    init(presentingSource: RepositoryPresentationDismisser) {
        self.presentingSource = presentingSource
    }
    
    func dismiss() {
        presentingSource.dismiss()
    }
    
    deinit {
        print("[RepositoryRouter] deinit")
    }
}
