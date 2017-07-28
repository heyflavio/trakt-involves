//
//  SearchViewController.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterInputProtocol?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    var searchResults: [SearchViewData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchController : UISearchController = UISearchController(searchResultsController:  nil)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchController.isActive = true
    }
    
    private func setupView() {
        tableView.register(SearchTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        setupSearchController()
    }
    
    private func setupSearchController() {
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.placeholder = "Search shows"
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = .involvesRed
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchView.addSubview(searchController.searchBar)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchController.searchBar.backgroundColor = .involvesRed
        
        searchController.searchBar
            .rx.text
            .orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { query in
                self.presenter?.searchTextDidChange(query)
            })
            .addDisposableTo(disposeBag)
        
        
        definesPresentationContext = false
        UISearchBar.appearance().tintColor = .involvesRed
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
    }

}

extension SearchViewController: SearchPresenterOutputProtocol {
    
    func setSearchResults(_ searchedResultsViewData: [SearchViewData]){
        searchResults = searchedResultsViewData
    }
}


extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.becomeFirstResponder()
        searchController.searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
        searchController.dismiss(animated: true, completion: {
            self.presenter?.didPressCancelButton()
        })
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        presenter?.didSelectRow(with: searchResults[indexPath.row])
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SearchTableViewCell
        cell.accessoryType = .disclosureIndicator
        let searchResult = searchResults[indexPath.row]
        
        cell.titleLabel?.text = searchResult.title
        cell.subtitleLabel?.text = searchResult.year
        
        return cell
    }
}
