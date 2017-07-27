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

    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
}

extension ShowInfoViewController: ShowInfoPresenterOutputProtocol {
    
}
