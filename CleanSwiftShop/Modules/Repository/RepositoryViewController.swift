//
//  RepositoryViewController.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import UIKit
import WebKit

class RepositoryViewController: UIViewController, RepositoryView {
    
    var viewDelegate: RepositoryViewDelegate!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize in Presenter
        viewDelegate.viewDidLoad()
    }
    
    func setRepository(_ repository: RepositoryListItem) {
        let request = URLRequest(url: URL(string: repository.htmlUrl)!)
        webView.load(request)
    }
    
    deinit {
        print("[RepositoryViewController] deinit")
    }
    
}
