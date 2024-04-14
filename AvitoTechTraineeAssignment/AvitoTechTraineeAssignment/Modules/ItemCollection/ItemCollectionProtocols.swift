//
//  ItemCollectionProtocols.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import Foundation

protocol ItemCollectionModuleInput {
    var moduleOutput: ItemCollectionModuleOutput? { get }
}

protocol ItemCollectionModuleOutput: AnyObject {
}

protocol ItemCollectionViewInput: AnyObject {
    func reloadSearchData()
    func handle(_ event: ViewEvents)
}

protocol ItemCollectionViewOutput: AnyObject {
    
    func entityTypes() -> [String]
    func limitTypes() -> [String]
    func searchTipsAmount() -> Int
    func searchTip(at index: Int) -> String
    func searchFilter(with text: String)
    func itemAmount() -> Int
    func item(at index: Int) -> Item
    func didTapOnCell(with indexPath: Int)
    func searchForItems(term: String, entityIndex: Int, limitIndex: Int)
}

protocol ItemCollectionInteractorInput: AnyObject {
    func receiveItems(term: String, entities: [String], limit: String)
}

protocol ItemCollectionInteractorOutput: AnyObject {
    func didReceive(items: [Item], term: String)
    func didFail(with error: Error)
}

protocol ItemCollectionRouterInput: AnyObject {
    func openItemCard(with item: Item)
}
