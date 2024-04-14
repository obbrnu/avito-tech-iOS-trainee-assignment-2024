//
//  ItemPageInteractor.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import Foundation

final class ItemPageInteractor {
    weak var output: ItemPageInteractorOutput?
}

extension ItemPageInteractor: ItemPageInteractorInput {
    func receiveArtist(id: Int64) {

        let queryItems = [URLQueryItem(name: "id", value: String(id))]
        
        NetworkManager.shared.loadArtist(with: queryItems) { [weak self] result in

            switch result {
            case .success(let artist):
                self?.output?.didReceive(artist: artist)
            case .failure(let error):
                self?.output?.didFail(with: error)
            }
        }
    }
    
}
