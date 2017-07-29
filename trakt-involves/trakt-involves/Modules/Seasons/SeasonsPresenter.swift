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
    var percentageValues: (Int?, Int?) = (nil, nil)
    var percentageWatched: Float?
    
    func viewDidLoad() {
        presenterOutput?.setNavigationTitle(watchlistItem!.title ?? "")
        interactor?.fetchImageUrl(for: watchlistItem!.tvdb)
        interactor?.fetchAllSeasons(for: watchlistItem!.traktId!)
        interactor?.fetchNextEpisode(for: watchlistItem!.traktId!)
        interactor?.fetchAiredEpisodesCount(for: watchlistItem!.traktId!)
    }
    
    func viewWillAppear() {
        interactor?.fetchWatchedEpisodes(for: watchlistItem!.traktId!)
    }
    
    func didPressBackButton() {
        router?.dismissCurrentScreen()
    }
    
    func didSelectRow(with viewData: SeasonViewData) {
        router?.presentEpisodesScreen(for: watchlistItem!, and: viewData.number!)
    }
    
}

extension SeasonsPresenter: SeasonsInteractorOutputProtocol {
    
    func fetchedImageUrl(_ url: String) {
        presenterOutput?.setupImageView(with: url)
    }
    
    func fetchedSeasons(_ viewData: [SeasonViewData]) {
        presenterOutput?.presentSeasons(viewData)
    }
    
    func fetchedNextEpisode(_ viewData: EpisodeViewData) {
        presenterOutput?.presentNextEpisode(viewData)
    }
    
    func fetchedWatchedEpisodesCount(_ count: Int) {
        percentageValues.0 = count
        
        calculateWatchedPercentage()
    }
    
    func fetchedAiredEpisodesCount(_ count: Int) {
        percentageValues.1 = count
        
        calculateWatchedPercentage()
    }
}

extension SeasonsPresenter {
    
    fileprivate func calculateWatchedPercentage() {
        
        if let count = percentageValues.0,
            let airedEpisodes = percentageValues.1,
            airedEpisodes > 0 {
            
            let percentage = (Float(count) / Float(airedEpisodes)) * 100
            presenterOutput?.setPercentageWatched("\(String(format: "%.0f", percentage.rounded()))% watched")
        }
    }
    
}

