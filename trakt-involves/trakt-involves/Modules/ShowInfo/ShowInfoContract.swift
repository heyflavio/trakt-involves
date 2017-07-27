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
    
    func viewDidLoad()
    func viewWillAppear()
    func didPressBackButton()
}

protocol ShowInfoPresenterOutputProtocol: class {
    var presenter: ShowInfoPresenterInputProtocol? { get set }
}

protocol ShowInfoInteractorInputProtocol: class {
    weak var interactorOutput: ShowInfoInteractorOutputProtocol? { get set }
}

protocol ShowInfoInteractorOutputProtocol: class {
    var interactor: ShowInfoInteractorInputProtocol? { get set }
}

protocol ShowInfoRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule() -> UIViewController
    
    func dismissCurrentScreen()
}
