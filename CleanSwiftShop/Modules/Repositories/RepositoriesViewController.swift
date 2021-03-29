//
//  RepositoriesViewController.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 27/03/2021.
//

import Foundation
import UIKit

class RepositoriesViewController: UIViewController, RepositoriesView {
    
    private var dataSource: RepositoryListItemDataSource!
    
    var interactor: RepositoriesInteractorProtocol!
    var router: RepositoriesRouterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = RepositoryListItemDataSource(for: tableView)
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didChangeValueForRefreshControl), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        // Initialize in Presenter
        interactor.refreshRepositories()
    }
    
    func setItems(_ items: [RepositoryListItem]) {
        dataSource.items = items
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            tableView.refreshControl?.beginRefreshing()
        } else {
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func didChangeValueForRefreshControl(_ refreshControl: UIRefreshControl) {
        interactor.refreshRepositories()
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.items[indexPath.row]
        router.navigateToRepository(item)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
