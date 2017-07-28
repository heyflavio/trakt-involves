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
    
    var title: String?
    var traktId: String?
    var tvdb: String?
    
    func viewDidLoad() {
        presenterOutput?.setupView(with: title!)
        interactor?.fetchImageUrl(for: tvdb)
        interactor?.fetchShowInfo(for: traktId!)
    }
    
    func viewWillAppear() {
        
    }
    
    func didPressAddToWatchlistButton() {
        interactor?.addShowToWatchlist()
    }
    
    func didPressBackButton() {
        router?.dismissCurrentScreen()
    }
}

extension ShowInfoPresenter: ShowInfoInteractorOutputProtocol {
    
    func fetchedImageUrl(_ url: String) {
        presenterOutput?.setupImageView(with: url)
    }
    
    func fetchedShowInfo(_ showInfo: ShowInfoViewData) {
        presenterOutput?.setupView(with: showInfo)
    }
}
