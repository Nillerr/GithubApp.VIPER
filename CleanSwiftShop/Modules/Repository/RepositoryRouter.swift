//
//  RepositoryRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

class RepositoryRouter {
    
    let presentation: Dismissable
    
    init(presentation: Dismissable) {
        self.presentation = presentation
    }
    
    func dismiss() {
        presentation.dismiss()
    }
    
    deinit {
        print("[RepositoryRouter] deinit")
    }
}
