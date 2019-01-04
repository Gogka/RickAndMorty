//
//  RMStandartCellConfigurator.swift
//  Rick&Morty
//
//  Created by Игорь Томилин on 12/30/18.
//  Copyright © 2018 igortomilin. All rights reserved.
//

import UIKit
import RMKit

final class RMStandartCellConfigurator: RMCellConfigurator {
    static var identificator: String { return String(describing: type(of: RMCharacterCell.self)) }
    
    private let character: RMCharacter
    private var avatar: UIImage?
    private var task: URLSessionDataTask?
    private var onLoadCompletion: ((RMResult<UIImage>) -> ())?
    
    init(character: RMCharacter) {
        self.character = character
        guard let avatarId = character.avatar else { return }
        task = RMService.shared.loadAvatar(forIdentificator: avatarId, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoadCompletion?(result)
                guard case let RMResult.successful(image) = result else { return }
                self?.avatar = image
            }
        })
    }
    
    func configure(_ cellView: UIView) {
        guard let cell = cellView as? RMCharacterCell else { return }
        cell.characterId = character.id
        cell.nameLabel?.text = character.name
        if let avatar = self.avatar {
            cell.avatarImageView?.image = avatar
        } else {
            cell.avatarImageView?.image = nil
            if task != nil {
                onLoadCompletion = { [weak self] result in
                    guard let sSelf = self, case let RMResult.successful(image) = result,
                        cell.characterId == sSelf.character.id else { return }
                    cell.avatarImageView?.image = image
                }
                startLoadingAvatar()
            }
        }
    }
    
    func prefetchData() {
        startLoadingAvatar()
    }
    
    func cancelPrefetchData() {
        task?.suspend()
    }
    
    private func startLoadingAvatar() {
        guard let task = self.task, ![URLSessionDataTask.State.completed, .running].contains(task.state) else { return }
        task.resume()
    }
}
