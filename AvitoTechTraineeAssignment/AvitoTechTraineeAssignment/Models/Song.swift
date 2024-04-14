//
//  Song.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 12.04.2024.
//

import Foundation

struct Song: ReusableModel, EntityWithImageProtocol {
    
    typealias Cell = SongCollectionViewCell
    typealias View = SongInfoView
    
    let id: String
    let wrapperType: String
    let kind: String
    let artistId: Int64?
    let collectionId: Int64
    let artistName: String
    let collectionName: String
    let name: String
    let viewUrl: String
    let imageUrl: String?
    let price: Double?
    let releaseDate: String
    let explicitness: String
    let trackCount: Int
    let trackNumber: Int
    let time: Int
    let country: String
    let currency: String?
    let primaryGenreName: String
        
    init(networkModel: SongDescription) {
        id = String(networkModel.id)
        wrapperType = networkModel.wrapperType
        kind = networkModel.kind
        artistId = networkModel.artistId
        collectionId = networkModel.collectionId
        artistName = networkModel.artistName
        collectionName = networkModel.collectionName
        name = networkModel.name
        viewUrl = networkModel.viewUrl
        imageUrl = networkModel.imageUrl
        price = networkModel.price
        releaseDate = networkModel.releaseDate
        explicitness = networkModel.explicitness
        trackCount = networkModel.trackCount
        trackNumber = networkModel.trackNumber
        time = networkModel.time
        country = networkModel.country
        currency = networkModel.currency
        primaryGenreName = networkModel.primaryGenreName
    }
        
}
