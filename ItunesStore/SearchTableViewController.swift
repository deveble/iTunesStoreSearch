//
//  SearchTableViewController.swift
//  ItunesStore
//
//  Created by User on 2/21/20.
//  Copyright © 2020 deveble. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    // MARK: - Properties
    var searchBar: UISearchBar?
    var searchContactsController: UISearchController?
    private let search = Search()
    
    
    struct CellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let emptyResultCell = "EmptyResultCell"
        static let loadingCell = "LoadingCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupTableView()
        correctSearchBarForCurrentIOSVersion().becomeFirstResponder()
    }
    
    // MARK: - Methods
    fileprivate func setupSearchController() {
        if #available(iOS 11.0, *) {
            searchContactsController = UISearchController(searchResultsController: nil)
            searchContactsController?.searchResultsUpdater = self
            searchContactsController?.obscuresBackgroundDuringPresentation = false
            searchContactsController?.searchBar.delegate = self
            navigationItem.searchController = searchContactsController
        } else {
            searchBar = UISearchBar()
            searchBar?.delegate = self
            searchBar?.placeholder = "Search"
            searchBar?.searchBarStyle = .minimal
            searchBar?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
            tableView.tableHeaderView = searchBar
        }
    }
    
    fileprivate func setupTableView(){
//        extendedLayoutIncludesOpaqueBars = true
//        definesPresentationContext = true
//        edgesForExtendedLayout = UIRectEdge.top
        
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: CellIdentifiers.searchResultCell)
        tableView.register(EmptyResultCell.self, forCellReuseIdentifier: CellIdentifiers.emptyResultCell)
        tableView.register(LoadingResultCell.self, forCellReuseIdentifier: CellIdentifiers.loadingCell)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
    }
    
    fileprivate func correctSearchBarForCurrentIOSVersion() -> UISearchBar {
        var searchBar: UISearchBar!
        if #available(iOS 11.0, *) {
            searchBar = self.searchContactsController?.searchBar
        } else {
            searchBar = self.searchBar
        }
        return searchBar
    }
    
    fileprivate func searchBarText() -> String? {
        return correctSearchBarForCurrentIOSVersion().text
    }
    
    // MARK:- Helper Methods
    func showNetworkError() {
        let alert = UIAlertController(title: NSLocalizedString("Whoops...", comment: "Network error Alert title"), message: NSLocalizedString("There was an error accessing the iTunes Store. Please try again.", comment: "Network error message"), preferredStyle: .alert)
        
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button title"), style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


// MARK: - UITableViewDelegate / UITableViewDatasource
extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch search.state {
        case .notSearchedYet:
            return 0
        case .loading:
            return 1
        case .noResults:
            return 1
        case .results(let list):
            return list.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch search.state {
        case .notSearchedYet:
            fatalError("Should never get here")
            
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingCell, for: indexPath) as! LoadingResultCell
            cell.activityIndicator.startAnimating()
            return cell
            
        case .noResults:
            return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.emptyResultCell, for: indexPath)
            
        case .results(let list):
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            
            let searchResult = list[indexPath.row]
            cell.configure(for: searchResult)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      switch search.state {
      case .notSearchedYet, .loading, .noResults:
        return nil
      case .results:
        return indexPath
      }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if case .results(let list) = search.state {
            let viewController = SearchDetailViewController(result: list[indexPath.row])
            presentPanModal(viewController)
        }
    }
}


// MARK: - UISearchBarDelegate
extension SearchTableViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        correctSearchBarForCurrentIOSVersion().endEditing(true)
        performSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        guard #available(iOS 11.0, *) else {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
            return
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        guard #available(iOS 11.0, *) else {
            searchBar.setShowsCancelButton(true, animated: true)
            return true
        }
        return true
    }
    
    func performSearch() {
        let text = searchBarText()
        title = String(format: "searched: %@", text!)
        search.performSearch(for: searchBarText()!, category: .all, completion: {success in
            if !success {
                self.showNetworkError()
            }
            self.tableView.reloadData()
        })
        
        self.tableView.reloadData()
        correctSearchBarForCurrentIOSVersion().resignFirstResponder()
        
    }
}

extension SearchTableViewController { /* hiding keyboard */
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            searchContactsController?.resignFirstResponder()
            searchContactsController?.searchBar.resignFirstResponder()
        } else {
            searchBar?.resignFirstResponder()
        }
    }
    
}
