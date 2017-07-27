//
//  SearchPresenter.swift
//  trakt-involves
//
//  Created by iMac on 27/07/17.
//  Copyright © 2017 Flavio Kruger Bittencourt. All rights reserved.
//

class SearchPresenter: SearchPresenterInputProtocol {

    weak var presenterOutput: SearchPresenterOutputProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?

    func viewDidLoad() {
        
    }
    
    func searchTextDidChange(_ text: String) {
        interactor?.search(query: text)
    }

    func didSelectRow(with searchViewData: SearchViewData) {
        router?.presentShowInfoScreen()
    }
    
    func didPressCancelButton() {
        router?.dismissCurrentScreen()
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func searchedResults(_ searchedResultsViewData: [SearchViewData]) {
        presenterOutput?.setSearchResults(searchedResultsViewData)
    }
}
