//
//  RepositoryRouter.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

protocol RepositoryRouterProtocol: AnyObject {
    func dismiss()
}

class RepositoryRouter: RepositoryRouterProtocol {
    
    private let _dismiss: () -> Void
    
    init(navigationController: UINavigationController) {
        self._dismiss = { navigationController.popViewController(animated: true) }
    }
    
    init(viewController: UIViewController) {
        self._dismiss = { viewController.dismiss(animated: true) }
    }
    
    func dismiss() {
        _dismiss()
    }
    
    deinit {
        print("[RepositoryRouter] deinit")
    }
}
