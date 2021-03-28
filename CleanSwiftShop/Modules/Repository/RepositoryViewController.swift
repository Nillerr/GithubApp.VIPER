//
//  RepositoryViewController.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import UIKit

class RepositoryViewController: UIViewController, RepositoryView {
    
    var viewDelegate: RepositoryViewDelegate!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize in Presenter
        viewDelegate.viewDidLoad()
    }
    
    func setRepository(_ repository: RepositoryListItem) {
        titleLabel.text = repository.fullName
    }
    
    @IBAction func didTouchUpInsideClose(_ sender: UIButton) {
        viewDelegate.didClose()
    }
    
    deinit {
        print("[RepositoryViewController] deinit")
    }
    
}
