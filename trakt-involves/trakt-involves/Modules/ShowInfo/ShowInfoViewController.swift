//
//  ShowInfoViewController.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class ShowInfoViewController: UIViewController {
    
    var presenter: ShowInfoPresenterInputProtocol?

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var info: String? = ""
    var overview: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        presenter?.didPressBackButton()
    }

    @IBAction func didPressWatchButton(_ sender: UIButton) {
        presenter?.didPressAddToWatchlistButton()
    }
    
    private func setupView() {
        tableView.register(DescriptionTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80.0
        tableView.tableFooterView = UIView()
    }
}

extension ShowInfoViewController: ShowInfoPresenterOutputProtocol {
    
    func setupView(with title: String) {
        showTitleLabel.text = title
    }
    
    func setupImageView(with url: String) {
        if let url = URL(string: url) {
            showImageView.kf.setImage(with: url)
        }
    }
    
    func setupView(with showInfo: ShowInfoViewData?) {
        overview = showInfo?.overview
        info = "\(showInfo!.year!), \(showInfo!.network!)"
        tableView.reloadData()
    }
}


extension ShowInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension ShowInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DescriptionTableViewCell
        cell.titleLabel.text = info
        cell.descriptionTextView.text = overview
        return cell
    }
}
