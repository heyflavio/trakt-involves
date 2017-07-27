//
//  MyTvSeriesViewController.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

class MyTvSeriesViewController: UIViewController {
    
    var presenter: MyTvSeriesPresenterInputProtocol?

    fileprivate var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        let traktAuth = SFSafariViewController(url: URL(string: Endpoints.Authentication.authorize.url(authContext: true))!)
        traktAuth.delegate = self
        UIApplication.topViewController(includingSupportingControllers: true)!.present(traktAuth, animated: true, completion: nil)
    }
}

extension MyTvSeriesViewController: MyTvSeriesPresenterOutputProtocol {
    
}

extension MyTvSeriesViewController: SFSafariViewControllerDelegate {
    
}
