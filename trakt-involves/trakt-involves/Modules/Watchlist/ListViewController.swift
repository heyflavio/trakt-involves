//
//  ListViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ListPresenterInputProtocol?
    
    var List: [ListViewData] = [] {
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

extension ListViewController: ListPresenterOutputProtocol {
    
    func setList(_ viewData: [ListViewData]) {
        List = viewData
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(with: List[indexPath.row])
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SearchTableViewCell
        cell.accessoryType = .disclosureIndicator
        let item = List[indexPath.row]
        
        cell.titleLabel?.text = item.title
        cell.subtitleLabel?.text = "\(item.year!)"
        
        return cell
    }
}
