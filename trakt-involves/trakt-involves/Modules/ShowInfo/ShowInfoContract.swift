//
//  ShowInfoContract.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol ShowInfoPresenterInputProtocol: class {
    weak var presenterOutput: ShowInfoPresenterOutputProtocol? { get set }
    var interactor: ShowInfoInteractorInputProtocol? { get set }
    var router: ShowInfoRouterProtocol? { get set }
    
    var title: String? { get set }
    var traktId: String? { get set }
    var tvdb: String? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didPressAddToWatchlistButton()
    func didPressBackButton()
}

protocol ShowInfoPresenterOutputProtocol: class {
    var presenter: ShowInfoPresenterInputProtocol? { get set }
    
    func setupView(with title: String)
    func setupImageView(with url: String)
    func setupView(with showInfo: ShowInfoViewData?)
}

protocol ShowInfoInteractorInputProtocol: class {
    weak var interactorOutput: ShowInfoInteractorOutputProtocol? { get set }
    
    func fetchImageUrl(for tvdbId: String?)
    func fetchShowInfo(for traktId: String)
    func addShowToWatchlist()
}

protocol ShowInfoInteractorOutputProtocol: class {
    var interactor: ShowInfoInteractorInputProtocol? { get set }
    
    func fetchedImageUrl(_ url: String)
    func fetchedShowInfo(_ showInfo: ShowInfoViewData)
}

protocol ShowInfoRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule(with traktId: String, tvdb: String?, title: String) -> UIViewController
    
    func dismissCurrentScreen()
}
