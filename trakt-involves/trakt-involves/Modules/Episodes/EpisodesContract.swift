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
    
    func viewDidLoad()
    func viewWillAppear()
}

protocol EpisodesPresenterOutputProtocol: class {
    var presenter: EpisodesPresenterInputProtocol? { get set }
}

protocol EpisodesInteractorInputProtocol: class {
    weak var interactorOutput: EpisodesInteractorOutputProtocol? { get set }
}

protocol EpisodesInteractorOutputProtocol: class {
    var interactor: EpisodesInteractorInputProtocol? { get set }
}

protocol EpisodesRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule(with traktId: Int) -> UIViewController
}
