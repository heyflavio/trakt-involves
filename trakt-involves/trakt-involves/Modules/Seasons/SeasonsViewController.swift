//
//  SeasonsViewController.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class SeasonsViewController: UIViewController {
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var nextEpisodeTitleLabel: UILabel!
    @IBOutlet weak var nextEpisodeInfoLabel: UILabel!
    @IBOutlet weak var percentageWatchedLabel: UILabel!
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        presenter?.viewWillAppear()
    }

    private func setupView() {
        tableView.register(ShowTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        presenter?.didPressBackButton()
    }
}

extension SeasonsViewController: SeasonsPresenterOutputProtocol {
    
    func setNavigationTitle(_ title: String) {
        showTitleLabel.text = title
    }
    
    func setupImageView(with url: String) {
        if let url = URL(string: url) {
            showImageView.kf.setImage(with: url)
        }
    }
    func presentSeasons(_ viewData: [SeasonViewData]) {
        seasonsViewData = viewData
    }
    
    func presentNextEpisode(_ viewData: EpisodeViewData) {
        nextEpisodeTitleLabel.text = "Next episode (\(viewData.firstAired)):"
        nextEpisodeInfoLabel.text = viewData.title
    }
    
    func setPercentageWatched(_ percentage: String) {
        percentageWatchedLabel.text = percentage
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
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ShowTableViewCell
        cell.accessoryType = .disclosureIndicator
        let item = seasonsViewData[indexPath.row]
        
        cell.titleLabel?.text = "\(item.number!)"
        cell.subtitleLabel?.text = item.title ?? ""
        
        return cell
    }
}
