//
//  MyTvSeriesPresenter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

class MyTvSeriesPresenter: MyTvSeriesPresenterInputProtocol {

    weak var presenterOutput: MyTvSeriesPresenterOutputProtocol?
    var interactor: MyTvSeriesInteractorInputProtocol?
    var router: MyTvSeriesRouterProtocol?

    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
}

extension MyTvSeriesPresenter: MyTvSeriesInteractorOutputProtocol {
    
}
