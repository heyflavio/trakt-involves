//
//  WatchlistViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController {
    
    var presenter: WatchlistPresenterInputProtocol?    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()

    }
    
    @IBAction func didPressSearchButton(_ sender: UIBarButtonItem) {
        presenter?.didPressSearchButton()
    }
}

extension WatchlistViewController: WatchlistPresenterOutputProtocol {
    
}
