//
//  CSSearchQueryController.swift
//  CSSearchQueryController
//
//  Created by alexruperez on 22/9/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import Foundation
import CoreSpotlight

public protocol CSSearchQueryHandler {
    func updateSearchQueryResults(searchableItems: [CSSearchableItem])
}

extension UIViewController: CSSearchQueryHandler {
    open func updateSearchQueryResults(searchableItems: [CSSearchableItem]) {
        print(searchableItems)
    }
}

public class CSSearchQueryController: UISearchController {
    var queryFields = ["displayName"]
    var queryCombine = " || "
    var queryOperator = "=="
    var queryBegin = "\""
    var queryEnd = "\""
    var queryModifier = "cd"
    var attributes = ["displayName"]
    fileprivate var searchQuery: CSSearchQuery? = nil

    convenience public init() {
        self.init(searchResultsController: nil)
    }

    override public init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        delegate = self
        searchResultsUpdater = self
        searchBar.delegate = self
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CSSearchQueryController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        searchQuery?.cancel()
        guard let searchBarText = searchController.searchBar.text, searchBarText.characters.count > 0 else {
            return
        }
        var queryString = ""
        for queryField in queryFields {
            if queryString.characters.count > 0 {
                queryString.append(queryCombine)
            }
            queryString.append("\(queryField) \(queryOperator) \(queryBegin)\(searchBarText)\(queryEnd)\(queryModifier)")
        }
        searchQuery = CSSearchQuery(queryString:queryString, attributes: attributes)
        var searchableItems = [CSSearchableItem]()
        searchQuery!.foundItemsHandler = { items in
            searchableItems.append(contentsOf: items)
        }
        searchQuery!.completionHandler = { error in
            guard error == nil else {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.searchResultsController?.updateSearchQueryResults(searchableItems: searchableItems)
            }
        }
        searchQuery!.start()
    }
}

extension CSSearchQueryController: UISearchControllerDelegate {
    public func willPresentSearchController(_ searchController: UISearchController) {

    }

    public func didPresentSearchController(_ searchController: UISearchController) {

    }

    public func willDismissSearchController(_ searchController: UISearchController) {

    }

    public func didDismissSearchController(_ searchController: UISearchController) {

    }

    public func presentSearchController(_ searchController: UISearchController) {
        
    }
}

extension CSSearchQueryController: UISearchBarDelegate {
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }

    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }

    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    }

    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {

    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }

    public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {

    }

    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

    }
}
