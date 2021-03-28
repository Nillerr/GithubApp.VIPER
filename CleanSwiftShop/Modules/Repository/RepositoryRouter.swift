//
//  RepositoryRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

class RepositoryRouter {
    
    let dismissable: Dismissable
    
    init(dismissable: Dismissable) {
        self.dismissable = dismissable
    }
    
    func dismiss() {
        dismissable.dismiss()
    }
    
    deinit {
        print("[RepositoryRouter] deinit")
    }
}
