//
//  WatchlistViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WatchlistPresenterInputProtocol?
    
    var watchlist: [WatchlistViewData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()

    }
    
    private func setupView() {
        tableView.register(SearchTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func didPressSearchButton(_ sender: UIBarButtonItem) {
        presenter?.didPressSearchButton()
    }
}

extension WatchlistViewController: WatchlistPresenterOutputProtocol {
    
    func setWatchList(_ viewData: [WatchlistViewData]) {
        watchlist = viewData
    }
}

extension WatchlistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(with: watchlist[indexPath.row])
    }
}

extension WatchlistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SearchTableViewCell
        cell.accessoryType = .disclosureIndicator
        let item = watchlist[indexPath.row]
        
        cell.titleLabel?.text = item.title
        cell.subtitleLabel?.text = "\(item.year!)"
        
        return cell
    }
}
