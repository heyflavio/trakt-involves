//
//  SeasonsViewController.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class SeasonsViewController: UIViewController {
    
    @IBOutlet weak var nextEpisodeInfoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SeasonsPresenterInputProtocol?
    
    var seasonsViewData: [SeasonViewData] = [] {
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
}

extension SeasonsViewController: SeasonsPresenterOutputProtocol {
    
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    func presentSeasons(_ viewData: [SeasonViewData]) {
        seasonsViewData = viewData
    }
    
    func presentNextEpisode(_ viewData: EpisodeViewData) {
        nextEpisodeInfoLabel.text = viewData.title ?? "There's no next episodes"
    }
}

extension SeasonsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(with: seasonsViewData[indexPath.row])
    }
}

extension SeasonsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonsViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SearchTableViewCell
        cell.accessoryType = .disclosureIndicator
        let item = seasonsViewData[indexPath.row]
        
        cell.titleLabel?.text = "\(item.number!)"
        cell.subtitleLabel?.text = item.title ?? ""
        
        return cell
    }
}
