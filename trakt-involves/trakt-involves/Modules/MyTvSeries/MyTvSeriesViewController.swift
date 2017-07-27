//
//  MyTvSeriesViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class MyTvSeriesViewController: UIViewController {
    
    var presenter: MyTvSeriesPresenterInputProtocol?    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()

    }
}

extension MyTvSeriesViewController: MyTvSeriesPresenterOutputProtocol {
    
}
