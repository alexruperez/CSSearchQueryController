//
//  ViewController.swift
//  CSSearchQueryControllerExample
//
//  Created by alexruperez on 22/9/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import UIKit
import CSSearchQueryController

class ViewController: UITableViewController {

    var searchQueryController: CSSearchQueryController?
    let searchableIndex = CSSearchableIndex.default()
    var searchableItems: [CSSearchableItem]? {
        didSet {
            tableView.reloadData()
        }
    }

    convenience public init() {
        self.init(style: .plain)
    }

    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        view.backgroundColor = .clear
        tableView.backgroundView = nil
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        definesPresentationContext = true
        searchQueryController = CSSearchQueryController(searchResultsController: ViewController())
        searchQueryController!.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchQueryController!.searchBar
        searchableItems = CSSearchableItemGenerator.generate(amount: 100)
        if let searchableItems = searchableItems, CSSearchableIndex.isIndexingAvailable() {
            searchableIndex.deleteAllSearchableItems(completionHandler: { error in
                print(error)
            })
            searchableIndex.indexSearchableItems(searchableItems, completionHandler: { error in
                print(error)
            })
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchableItems = searchableItems else {
            return 0
        }
        return searchableItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: String(reflecting: UITableViewCell.self))
        let cell: UITableViewCell = dequeuedCell != nil ? dequeuedCell! : UITableViewCell(style: .subtitle, reuseIdentifier: String(reflecting: UITableViewCell.self))
        guard let searchableItems = searchableItems else {
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
            return cell
        }
        cell.textLabel?.text = searchableItems[indexPath.row].uniqueIdentifier
        cell.detailTextLabel?.text = searchableItems[indexPath.row].domainIdentifier
        return cell
    }

    override func updateSearchQueryResults(searchableItems: [CSSearchableItem]) {
        self.searchableItems = searchableItems
    }
}
