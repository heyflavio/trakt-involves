//
//  ListPresenter.swift
//  trakt-involves
//
//  Created by iMac on 26/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

class ListPresenter: ListPresenterInputProtocol {

    weak var presenterOutput: ListPresenterOutputProtocol?
    var interactor: ListInteractorInputProtocol?
    var router: ListRouterProtocol?

    var context: ShowContext?
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        if context == .watchlist {
            interactor?.fetchList()
        } else {
            interactor?.fetchWatched()
        }
    }
    
    
    func didPressSearchButton() {
        router?.presentSearchScreen()
    }
    
    func didSelectRow(with ListViewData: ListViewData) {
        router?.presentSeasonsScreen(for: ListViewData)
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func fetchedList(_ viewData: [ListViewData]) {
        presenterOutput?.setList(viewData)
    }
}
