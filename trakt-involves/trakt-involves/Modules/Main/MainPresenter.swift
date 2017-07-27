//
//  MainPresenter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

class MainPresenter: MainPresenterInputProtocol {
    
    weak var presenterOutput: MainPresenterOutputProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    required init(router: MainRouterProtocol) {
        self.router = router
    }
    
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    
}
