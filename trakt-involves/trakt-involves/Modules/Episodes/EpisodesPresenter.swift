//
//  EpisodesPresenter.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

class EpisodesPresenter: EpisodesPresenterInputProtocol {

    weak var presenterOutput: EpisodesPresenterOutputProtocol?
    var interactor: EpisodesInteractorInputProtocol?
    var router: EpisodesRouterProtocol?

    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
}

extension EpisodesPresenter: EpisodesInteractorOutputProtocol {
    
}
