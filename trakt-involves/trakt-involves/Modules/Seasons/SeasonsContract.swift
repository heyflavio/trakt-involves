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
    
    var traktId: Int? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didSelectRow(with viewData: SeasonViewData)
}

protocol SeasonsPresenterOutputProtocol: class {
    var presenter: SeasonsPresenterInputProtocol? { get set }
    
    func presentSeasons(_ viewData: [SeasonViewData])
}

protocol SeasonsInteractorInputProtocol: class {
    weak var interactorOutput: SeasonsInteractorOutputProtocol? { get set }
    
    func fetchAllSeasons(for id: Int)
}

protocol SeasonsInteractorOutputProtocol: class {
    var interactor: SeasonsInteractorInputProtocol? { get set }
    
    func fetchedSeasons(_ viewData: [SeasonViewData])
}

protocol SeasonsRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule(with traktId: Int) -> UIViewController
    
    func presentEpisodesScreen(for traktId: Int, and seasonNumber: Int)
}
