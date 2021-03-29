//
//  ModalViewControllerPresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import UIKit

struct ModalViewControllerPresentationSource: DismissablePresentationSource {
    
    let presentingViewController: UIViewController
    let title: String
    
    func present(_ viewController: UIViewController) {
        let modalViewController = ModalViewController()
        modalViewController.contentViewController = viewController
        modalViewController.title = title
        modalViewController.onClose = dismiss
        
        presentingViewController.present(modalViewController, animated: true)
    }
    
    func dismiss() {
        presentingViewController.dismiss(animated: true)
    }
    
}
