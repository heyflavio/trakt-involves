//
//  ShowInfoContract.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

enum InfoContext {
    case show, episode
}

protocol ShowInfoPresenterInputProtocol: class {
    weak var presenterOutput: ShowInfoPresenterOutputProtocol? { get set }
    var interactor: ShowInfoInteractorInputProtocol? { get set }
    var router: ShowInfoRouterProtocol? { get set }
    
    var context: InfoContext? { get set }
    var title: String? { get set }
    var traktId: Int? { get set }
    var tvdb: Int? { get set }
    
    var seasonNumber: Int? { get set }
    var episodeNumber: Int? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didPressAddToWatchlistButton()
    func didPressBackButton()
}

protocol ShowInfoPresenterOutputProtocol: class {
    var presenter: ShowInfoPresenterInputProtocol? { get set }
    
    func setupView(with context: InfoContext, title: String?)
    func setupImageView(with url: String)
    func setupView(with showInfo: ShowInfoViewData?)
    func setupView(with episodeInfo: EpisodeViewData?)
    func setWatchedButtonText(_ text: String)
}

protocol ShowInfoInteractorInputProtocol: class {
    weak var interactorOutput: ShowInfoInteractorOutputProtocol? { get set }
    
    func fetchImageUrl(for tvdbId: Int?)
    func fetchShowInfo(for traktId: Int)
    func addShowToWatchlist()
    func removeShowFromWatchlist()

    func fetchEpisodeInfo(for traktId: Int, seasonNumber: Int, episodeNumber: Int)
    func fetchWatchedState(for traktId: Int)
    func markEpisodeAsWatched()
    func unmarkEpisodeAsWatched()
}

protocol ShowInfoInteractorOutputProtocol: class {
    var interactor: ShowInfoInteractorInputProtocol? { get set }
    
    func fetchedImageUrl(_ url: String)
    func fetchedShowInfo(_ showInfo: ShowInfoViewData)
    func addedShowToWatchlist()
    func fetchedEpisodeInfo(_ episodeInfo: EpisodeViewData)
    func fetchedWatchedState(_ watched: Bool)
    func markedEpisodeAsWatched()
    func unmarkedEpisodeAsWatched()
}

protocol ShowInfoRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule(with context: InfoContext,
                               traktId: Int,
                               tvdb: Int?,
                               title: String?,
                               seasonNumber: Int?,
                               episodeNumber: Int?) -> UIViewController
    
    func dismissCurrentScreen()
    func dismissNavigationController()
}
