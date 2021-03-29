//
//  RepositoryRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation

class RepositoryRouter {
    
    let presentationSource: RepositoryPresentationSource
    
    init(presentationSource: RepositoryPresentationSource) {
        self.presentationSource = presentationSource
    }
    
    func dismiss() {
        presentationSource.dismiss()
    }
    
    deinit {
        print("[RepositoryRouter] deinit")
    }
}
