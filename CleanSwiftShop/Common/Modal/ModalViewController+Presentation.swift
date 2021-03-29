//
//  ModalViewController+Presentation.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import UIKit

extension ModalViewController {
    
    static func present(_ viewController: UIViewController, title: String, from presentingViewController: UIViewController) {
        let modalViewController = ModalViewController()
        modalViewController.contentViewController = viewController
        modalViewController.title = title
        modalViewController.onClose = { [weak presentingViewController] in
            presentingViewController?.dismiss(animated: true)
        }
        
        presentingViewController.present(modalViewController, animated: true)
    }
    
}
