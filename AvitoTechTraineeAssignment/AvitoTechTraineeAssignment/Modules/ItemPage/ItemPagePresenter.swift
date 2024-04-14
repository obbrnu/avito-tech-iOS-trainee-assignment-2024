//
//  ItemPagePresenter.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import Foundation

final class ItemPagePresenter {
    weak var view: ItemPageViewInput?
    weak var moduleOutput: ItemPageModuleOutput?
    
    private let router: ItemPageRouterInput
    private let interactor: ItemPageInteractorInput
    
    private let item: Item
    
    private var artist: ArtistDescription?
    
    init(router: ItemPageRouterInput, interactor: ItemPageInteractorInput, item: Item) {
        self.router = router
        self.interactor = interactor
        self.item = item
        self.artist = nil
    }
}

extension ItemPagePresenter: ItemPageModuleInput {
}

extension ItemPagePresenter: ItemPageViewOutput {
    
    func loadArtist(with id: Int64?) {
        guard let id else {
            view?.handle(.error("no artist"))
            return
        }
        view?.handle(.loading)
        interactor.receiveArtist(id: id)
    }
    
    func getArtist() -> ArtistDescription {
        artist!
    }
}

extension ItemPagePresenter: ItemPageInteractorOutput {
    func didReceive(artist: ArtistDescription) {
        self.artist = artist
        view?.handle(.success(""))
    }
    
    func didFail(with error: Error) {
        view?.handle(.error(error.localizedDescription))
    }
    

}
