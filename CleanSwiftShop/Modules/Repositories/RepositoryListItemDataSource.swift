//
//  RepositoryListItemDataSource.swift
//  CleanSwiftShop
//
//  Created by Nicklas on 28/03/2021.
//

import Foundation
import UIKit

class RepositoryListItemDataSource: NSObject, UITableViewDataSource {
    
    weak var tableView: UITableView!
    
    var items: [RepositoryListItem] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    init(for tableView: UITableView) {
        self.tableView = tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepositoryListItem")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListItem", for: indexPath)
        cell.textLabel?.text = item.fullName
        
        return cell
    }
}
