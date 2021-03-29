//
//  ModalViewControllerPresentationSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import UIKit

extension ModalPresentationSource {
    
    func present(_ viewController: UIViewController, title: String) {
        let modalViewController = ModalViewController()
        modalViewController.contentViewController = viewController
        modalViewController.title = title
        modalViewController.onClose = dismiss
        
        present(modalViewController)
    }
    
}
