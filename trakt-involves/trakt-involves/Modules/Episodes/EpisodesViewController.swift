//
//  EpisodesViewController.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EpisodesPresenterInputProtocol?
    
    var episodesViewData: [EpisodeViewData] = [] {
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
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        presenter?.viewWillAppear()
    }

    
    private func setupView() {
        tableView.register(ShowTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

extension EpisodesViewController: EpisodesPresenterOutputProtocol {
    
    func presentEpisodes(_ viewData: [EpisodeViewData]) {
        episodesViewData = viewData
    }
}

extension EpisodesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(with: episodesViewData[indexPath.row])
    }
}

extension EpisodesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ShowTableViewCell
        cell.accessoryType = .disclosureIndicator
        let item = episodesViewData[indexPath.row]
        
        cell.titleLabel?.text = "\(item.number!)"
        cell.subtitleLabel?.text = item.title
        
        return cell
    }
}
