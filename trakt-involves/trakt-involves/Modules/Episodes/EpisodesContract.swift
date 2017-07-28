//
//  EpisodesContract.swift
//  trakt-involves
//
//  Created by iMac on 28/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol EpisodesPresenterInputProtocol: class {
    weak var presenterOutput: EpisodesPresenterOutputProtocol? { get set }
    var interactor: EpisodesInteractorInputProtocol? { get set }
    var router: EpisodesRouterProtocol? { get set }
    
    var watchlistItem: ListViewData? { get set }
    var seasonNumber: Int? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didSelectRow(with viewData: EpisodeViewData)
}

protocol EpisodesPresenterOutputProtocol: class {
    var presenter: EpisodesPresenterInputProtocol? { get set }
    
    func presentEpisodes(_ viewData: [EpisodeViewData])
}

protocol EpisodesInteractorInputProtocol: class {
    weak var interactorOutput: EpisodesInteractorOutputProtocol? { get set }
    
    func fetchAllEpisodes(for id: Int, and seasonNumber: Int)
}

protocol EpisodesInteractorOutputProtocol: class {
    var interactor: EpisodesInteractorInputProtocol? { get set }
    
    func fetchedEpisodes(_ viewData: [EpisodeViewData])
}

protocol EpisodesRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule(with watchlistItem: ListViewData, and seasonNumber: Int) -> UIViewController
    
    func presentShowInfoScreen(with watchlistItem: ListViewData, episodeViewData: EpisodeViewData)
}
