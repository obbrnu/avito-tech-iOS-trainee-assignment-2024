//
//  ItemCollectionInteractor.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import Foundation

final class ItemCollectionInteractor {
    weak var output: ItemCollectionInteractorOutput?
}

extension ItemCollectionInteractor: ItemCollectionInteractorInput {
    
    func receiveItems(term: String, entities: [String], limit: String) {
        
        let allEntities = entities.joined(separator: ",")
        let queryItems = [URLQueryItem(name: "term", value: term),
                          URLQueryItem(name: "entity", value: allEntities),
                          URLQueryItem(name: "limit", value: limit),]
        
        NetworkManager.shared.fetchItems(with: queryItems) { [weak self] result in
            switch result {
            case .success(let items):
                self?.output?.didReceive(items: items, term: term)
            case .failure(let error):
                self?.output?.didFail(with: error)
            }
        }
    }
}
