//
//  SeasonsPresenter.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

class SeasonsPresenter: SeasonsPresenterInputProtocol {

    weak var presenterOutput: SeasonsPresenterOutputProtocol?
    var interactor: SeasonsInteractorInputProtocol?
    var router: SeasonsRouterProtocol?

    var traktId: Int?
    
    func viewDidLoad() {
        interactor?.fetchAllSeasons(for: traktId!)
    }
    
    func viewWillAppear() {
        
    }
    
    func didSelectRow(with viewData: SeasonViewData) {
        router?.presentEpisodesScreen(for: traktId!, and: viewData.number!)
    }
    
}

extension SeasonsPresenter: SeasonsInteractorOutputProtocol {
    
    func fetchedSeasons(_ viewData: [SeasonViewData]) {
        presenterOutput?.presentSeasons(viewData)
    }
}
