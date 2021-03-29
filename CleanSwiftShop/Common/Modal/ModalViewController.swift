//
//  ModalViewController.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 29/03/2021.
//

import Foundation
import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var contentViewController: UIViewController? {
        didSet {
            if isViewLoaded {
                updateContentViewController()
            }
        }
    }
    
    var onClose: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = title
        
        updateContentViewController()
    }
    
    private func updateContentViewController() {
        if let currentViewController = children.first {
            currentViewController.view.removeFromSuperview()
            currentViewController.removeFromParent()
        }
        
        if let viewController = contentViewController {
            addChild(viewController)
            
            let view = viewController.view!
            contentView.addSubview(view)
        }
    }
    
    @IBAction func didTouchUpInsideClose(_ button: UIButton) {
        onClose?()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentViewController?.view.frame = contentView.bounds
    }
    
}
