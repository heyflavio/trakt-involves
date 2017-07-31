//
//  ListContract.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol ListPresenterInputProtocol: class {
    weak var presenterOutput: ListPresenterOutputProtocol? { get set }
    var interactor: ListInteractorInputProtocol? { get set }
    var router: ListRouterProtocol? { get set }
    
    var context: ShowContext? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didPressSearchButton()
    func didSelectRow(with ListViewData: ListViewData)
}

protocol ListPresenterOutputProtocol: class {
    var presenter: ListPresenterInputProtocol? { get set }
    
    func setList(_ viewData: [ListViewData])
}

protocol ListInteractorInputProtocol: class {
    weak var interactorOutput: ListInteractorOutputProtocol? { get set }
    
    func fetchList()
    func fetchWatched()
}

protocol ListInteractorOutputProtocol: class {
    var interactor: ListInteractorInputProtocol? { get set }
    
    func fetchedList(_ viewData: [ListViewData])
}

protocol ListRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule(with context: ShowContext) -> UIViewController
    
    func presentSearchScreen()
    func presentSeasonsScreen(for ListItem: ListViewData)
}
