//
//  ShowInfoPresenter.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

class ShowInfoPresenter: ShowInfoPresenterInputProtocol {

    weak var presenterOutput: ShowInfoPresenterOutputProtocol?
    var interactor: ShowInfoInteractorInputProtocol?
    var router: ShowInfoRouterProtocol?

    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
    func didPressBackButton() {
        router?.dismissCurrentScreen()
    }
}

extension ShowInfoPresenter: ShowInfoInteractorOutputProtocol {
    
}
