//
//  EpisodesViewController.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    var presenter: EpisodesPresenterInputProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }

}

extension EpisodesViewController: EpisodesPresenterOutputProtocol {
    
}
