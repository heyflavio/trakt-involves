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

    var watchlistItem: WatchlistViewData?
    var seasonNumber: Int?
    
    func viewDidLoad() {
        interactor?.fetchAllEpisodes(for: watchlistItem!.traktId!,
                                     and: seasonNumber!)
    }
    
    func viewWillAppear() {
        
    }
    
    func didSelectRow(with viewData: EpisodeViewData){
        router?.presentShowInfoScreen(with: watchlistItem!,
                                      episodeViewData: viewData)
    }
    
}

extension EpisodesPresenter: EpisodesInteractorOutputProtocol {
    
    func fetchedEpisodes(_ viewData: [EpisodeViewData]) {
        presenterOutput?.presentEpisodes(viewData)
    }
}
