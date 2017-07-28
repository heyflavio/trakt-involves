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

    var watchlistItem: ListViewData?
    
    func viewDidLoad() {
        presenterOutput?.setNavigationTitle(watchlistItem!.title ?? "")
        interactor?.fetchAllSeasons(for: watchlistItem!.traktId!)
        interactor?.fetchNextEpisode(for: watchlistItem!.traktId!)
        interactor?.fetchWatchedEpisodes(for: watchlistItem!.traktId!)
    }
    
    func viewWillAppear() {
        
    }
    
    func didSelectRow(with viewData: SeasonViewData) {
        router?.presentEpisodesScreen(for: watchlistItem!, and: viewData.number!)
    }
    
}

extension SeasonsPresenter: SeasonsInteractorOutputProtocol {
    
    func fetchedSeasons(_ viewData: [SeasonViewData]) {
        presenterOutput?.presentSeasons(viewData)
    }
    
    func fetchedNextEpisode(_ viewData: EpisodeViewData) {
        presenterOutput?.presentNextEpisode(viewData)
    }
}
