//
//  ItemPageProtocols.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import Foundation

protocol ItemPageModuleInput {
    var moduleOutput: ItemPageModuleOutput? { get }
}

protocol ItemPageModuleOutput: AnyObject {
}

protocol ItemPageViewInput: AnyObject {
    func handle(_ event: ViewEvents)
}

protocol ItemPageViewOutput: AnyObject {
    func loadArtist(with id: Int64?)
    func getArtist() -> ArtistDescription
}

protocol ItemPageInteractorInput: AnyObject {
    func receiveArtist(id: Int64)
}

protocol ItemPageInteractorOutput: AnyObject {
    func didReceive(artist: ArtistDescription)
    func didFail(with error: Error)
}

protocol ItemPageRouterInput: AnyObject {
}
