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
    
    var context: InfoContext?
    
    var title: String?
    var traktId: Int?
    var tvdb: Int?
    
    var seasonNumber: Int?
    var episodeNumber: Int?
    var watched = false {
        didSet {
            presenterOutput?.toggleWatchedButton(watched ? "Mark as unwatched" : "Mark as watched")
        }
    }
    
    func viewDidLoad() {
        presenterOutput?.setupView(with: context!, title: title)
        interactor?.fetchImageUrl(for: tvdb)
        
        if context == .show {
            interactor?.fetchShowInfo(for: traktId!)
        } else {
            interactor?.fetchEpisodeInfo(for: traktId!,
                                         seasonNumber: seasonNumber!,
                                         episodeNumber: episodeNumber!)
        }
        
    }
    
    func viewWillAppear() {
        
    }
    
    func didPressAddToWatchlistButton() {
        if context == . show {
            interactor?.addShowToWatchlist()
        } else if watched {
            interactor?.unmarkEpisodeAsWatched() 
        } else {
            interactor?.markEpisodeAsWatched()
        }
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
    
    func fetchedEpisodeInfo(_ episodeInfo: EpisodeViewData) {
        presenterOutput?.setupView(with: episodeInfo)
        interactor?.fetchWatchedState(for: episodeInfo.tracktId!)
    }
    
    func fetchedWatchedState(_ watched: Bool) {
        self.watched = watched
    }
    
    func markedEpisodeAsWatched() {
        watched = true
    }
    
    func unmarkedEpisodeAsWatched() {
        watched = false
    }
}
