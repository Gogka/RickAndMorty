//
//  RMListRemotePresenter.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/31/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation
import RMKit

class RMListRemotePresenter: RMListPresenter {
    private let model: RMListModel
    private weak var view: RMListView?
    private let router: RMListRouter
    
    init(model: RMListModel, router: RMListRouter) {
        self.model = model
        self.router = router
    }
    
    func attach(view: RMListView) {
        self.view = view
        model.attach(output: self)
        model.getNextCharacters()
    }
}

extension RMListRemotePresenter: RMListModelOutput {
    func didReceiveCharactersListResult(_ result: RMResult<([RMCharacter], Bool)>) {
        switch result {
        case let .successful(characters, isLastPage):
            let configurators = characters.map({
                RMStandartCellConfigurator(character: $0)
            })
            DispatchQueue.main.async { self.view?.updateCollection(withConfigurators: configurators) }
        case .error(let error):
            print(error)
        }
    }
}
