//
//  RMRemoteListModel.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/31/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import Foundation
import RMKit

class RMRemoteListModel: RMListModel {
    private var page: Int? = 0
    private weak var output: RMListModelOutput?
    private var listTask: URLSessionDataTask?
    private var characters = [RMCharacter]()
    
    func attach(output: RMListModelOutput) {
        self.output = output
    }
    
    func getNextCharacters() {
        guard let page = self.page, listTask.map({ $0.state != .running }) ?? true else { return }
        listTask = RMService.shared.getCharactersTask(forPage: page, completion: { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .successful(let response):
                let nextPage = response.info.nextPage
                sSelf.page = nextPage
                sSelf.characters += response.characters
                sSelf.output?.didReceiveCharactersListResult(.successful((response.characters, nextPage == nil)))
            case .error(let error):
                sSelf.output?.didReceiveCharactersListResult(.error(error))
            }
            
        })
        listTask?.resume()
    }
}
