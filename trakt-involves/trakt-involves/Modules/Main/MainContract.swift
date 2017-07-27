//
//  MainContract.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import UIKit

protocol MainPresenterInputProtocol: class {
    weak var presenterOutput: MainPresenterOutputProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var router: MainRouterProtocol? { get }
    
    init(router: MainRouterProtocol)
}

protocol MainPresenterOutputProtocol: class {
    var presenter: MainPresenterInputProtocol? { get set }

}

protocol MainInteractorInputProtocol: class {
    weak var interactorOutput: MainInteractorOutputProtocol? { get set }

}

protocol MainInteractorOutputProtocol: class {
    var interactor: MainInteractorInputProtocol? { get set }
    
}

protocol MainRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule() -> UIViewController

}
