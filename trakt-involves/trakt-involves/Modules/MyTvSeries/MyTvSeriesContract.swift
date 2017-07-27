//
//  MyTvSeriesContract.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol MyTvSeriesPresenterInputProtocol: class {
    weak var presenterOutput: MyTvSeriesPresenterOutputProtocol? { get set }
    var interactor: MyTvSeriesInteractorInputProtocol? { get set }
    var router: MyTvSeriesRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
}

protocol MyTvSeriesPresenterOutputProtocol: class {
    var presenter: MyTvSeriesPresenterInputProtocol? { get set }
}

protocol MyTvSeriesInteractorInputProtocol: class {
    weak var interactorOutput: MyTvSeriesInteractorOutputProtocol? { get set }
}

protocol MyTvSeriesInteractorOutputProtocol: class {
    var interactor: MyTvSeriesInteractorInputProtocol? { get set }
}

protocol MyTvSeriesRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule() -> UIViewController
}
