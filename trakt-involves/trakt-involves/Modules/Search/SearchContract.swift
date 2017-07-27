//
//  SearchContract.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

import Foundation
import UIKit

protocol SearchPresenterInputProtocol: class {
    weak var presenterOutput: SearchPresenterOutputProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    
    func viewDidLoad()
    
    func searchTextDidChange(_ text: String)
    func didSelectRow(with searchViewData: SearchViewData)
    func didPressCancelButton()
}

protocol SearchPresenterOutputProtocol: class {
    var presenter: SearchPresenterInputProtocol? { get set }
    
    func setSearchResults(_ searchedResultsViewData: [SearchViewData])
}

protocol SearchInteractorInputProtocol: class {
    weak var interactorOutput: SearchInteractorOutputProtocol? { get set }
    
    func search(query: String)
}

protocol SearchInteractorOutputProtocol: class {
    var interactor: SearchInteractorInputProtocol? { get set }
    
    func searchedResults(_ searchedResultsViewData: [SearchViewData])
}

protocol SearchRouterProtocol: class {
    weak var view: UIViewController? { get set }
    static func assembleModule() -> UIViewController
    
    func presentShowInfoScreen()
    func dismissCurrentScreen()
}
