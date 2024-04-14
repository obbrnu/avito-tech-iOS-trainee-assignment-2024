//
//  ItemCollectionPresenter.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import Foundation

final class ItemCollectionPresenter {
    
    weak var view: ItemCollectionViewInput?
    weak var moduleOutput: ItemCollectionModuleOutput?
    
    private let router: ItemCollectionRouterInput
    private let interactor: ItemCollectionInteractorInput
    
    
    private let limits: [String] = ["30", "50", "100"]
    
    private let entities: [String] = ["All", "Movie", "Song", "Album", "Audiobook"]
    
    private var items: [Item]
    
    private var filteredItems: [Item] = []
    
    private var searchTips: [String]
    
    private var filteredSearchTips: [String] = []
    
    private var searchFilter: String = ""
    
    private var itemFilter: String = ""
    
    init(router: ItemCollectionRouterInput, interactor: ItemCollectionInteractorInput) {
        self.router = router
        self.interactor = interactor
        searchTips = StorageManager.shared.loadLastSearches()
        items = []
    }
}

extension ItemCollectionPresenter: ItemCollectionModuleInput {
}

extension ItemCollectionPresenter: ItemCollectionViewOutput {
    
    func entityTypes() -> [String] {
        entities
    }
    
    func limitTypes() -> [String] {
        limits
    }
    
    func searchForItems(term: String, entityIndex: Int, limitIndex: Int) {
        view?.handle(.loading)
        
        var correctEntities: [String] = []
        if entityIndex == 0 {
            for index in 1..<entities.count {
                correctEntities.append(self.entities[index].lowercased())
            }
        } else {
            correctEntities.append(entities[entityIndex].lowercased())
        }
        
        let limit = limits[limitIndex]
        
        interactor.receiveItems(term: term, entities: correctEntities, limit: limit)
        saveRequest(with: term)
    }
    
    func searchTipsAmount() -> Int {
        if searchFilter == "" {
            return searchTips.count
        } else {
            return filteredSearchTips.count
        }
    }
    
    func searchTip(at index: Int) -> String {
        if searchFilter == "" {
            return searchTips[index]
        } else {
            return filteredSearchTips[index]
        }
    }
    
    func searchFilter(with text: String) {
        searchFilter = text
        filteredSearchTips = searchTips.compactMap{ $0.lowercased().contains(text.lowercased()) ? $0 : nil }
        view?.reloadSearchData()
    }
    
    func itemAmount() -> Int {
        items.count
    }
    
    func item(at index: Int) -> Item {
        items[index]
    }
    
    func didTapOnCell(with indexPath: Int) {
        router.openItemCard(with: item(at: indexPath))
    }
    
    private func saveRequest(with term: String) {
        
        StorageManager.shared.saveLastSearch(text: term)
        searchTips = StorageManager.shared.loadLastSearches()
        
        view?.reloadSearchData()
    }
    
}

extension ItemCollectionPresenter: ItemCollectionInteractorOutput {
    
    func didReceive(items: [Item], term: String) {
        self.items = items
        
        guard items.count != 0 else {
            view?.handle(.error("no data in database"))
            return
        }
        
        self.view?.handle(.success(term))
    }
    
    func didFail(with error: Error) {
        self.items = []
        view?.handle(.error(error.localizedDescription))
    }
    
}
