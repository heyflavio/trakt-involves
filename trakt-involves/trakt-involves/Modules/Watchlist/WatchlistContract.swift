//
//  WatchlistContract.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol WatchlistPresenterInputProtocol: class {
    weak var presenterOutput: WatchlistPresenterOutputProtocol? { get set }
    var interactor: WatchlistInteractorInputProtocol? { get set }
    var router: WatchlistRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didPressSearchButton()
    func didSelectRow(with watchlistViewData: WatchlistViewData)
}

protocol WatchlistPresenterOutputProtocol: class {
    var presenter: WatchlistPresenterInputProtocol? { get set }
    
    func setWatchList(_ viewData: [WatchlistViewData])
}

protocol WatchlistInteractorInputProtocol: class {
    weak var interactorOutput: WatchlistInteractorOutputProtocol? { get set }
    
    func fetchWatchList()
}

protocol WatchlistInteractorOutputProtocol: class {
    var interactor: WatchlistInteractorInputProtocol? { get set }
    
    func fetchedWatchList(_ viewData: [WatchlistViewData])
}

protocol WatchlistRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule() -> UIViewController
    
    func presentSearchScreen()
    func presentSeasonsScreen(for watchListItem: WatchlistViewData)
}
