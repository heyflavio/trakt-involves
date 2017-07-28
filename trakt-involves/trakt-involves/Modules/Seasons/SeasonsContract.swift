//
//  SeasonsContract.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol SeasonsPresenterInputProtocol: class {
    weak var presenterOutput: SeasonsPresenterOutputProtocol? { get set }
    var interactor: SeasonsInteractorInputProtocol? { get set }
    var router: SeasonsRouterProtocol? { get set }
    
    var watchlistItem: ListViewData? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didSelectRow(with viewData: SeasonViewData)
}

protocol SeasonsPresenterOutputProtocol: class {
    var presenter: SeasonsPresenterInputProtocol? { get set }
    
    func setNavigationTitle(_ title: String)
    func presentSeasons(_ viewData: [SeasonViewData])
    func presentNextEpisode(_ viewData: EpisodeViewData)
}

protocol SeasonsInteractorInputProtocol: class {
    weak var interactorOutput: SeasonsInteractorOutputProtocol? { get set }
    
    func fetchAllSeasons(for id: Int)
    func fetchNextEpisode(for id: Int)
    func fetchWatchedEpisodes(for id: Int)
}

protocol SeasonsInteractorOutputProtocol: class {
    var interactor: SeasonsInteractorInputProtocol? { get set }
    
    func fetchedSeasons(_ viewData: [SeasonViewData])
    func fetchedNextEpisode(_ viewData: EpisodeViewData)
}

protocol SeasonsRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule(with watchlistItem: ListViewData) -> UIViewController
    
    func presentEpisodesScreen(for watchlistItem: ListViewData, and seasonNumber: Int)
}
