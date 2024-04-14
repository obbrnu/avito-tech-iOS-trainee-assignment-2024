//
//  Album.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 12.04.2024.
//

import Foundation

struct Album: ReusableModel, EntityWithImageProtocol {

    typealias Cell = AlbumCollectionViewCell
    typealias View = AlbumInfoView
    
    let id: String
    let wrapperType: String
    let collectionType: String
    let artistId: Int64?
    let artistName: String
    let name: String
    let viewUrl: String
    let imageUrl:String?
    let price: Double?
    let explicitness: String
    let trackCount: Int
    let country: String
    let currency: String?
    let releaseDate: String
    let primaryGenreName: String
        
    init(networkModel: AlbumDescription) {
        id = String(networkModel.id)
        wrapperType = networkModel.wrapperType
        collectionType = networkModel.collectionType
        artistId = networkModel.artistId
        artistName = networkModel.artistName
        name = networkModel.name
        viewUrl = networkModel.viewUrl
        imageUrl = networkModel.imageUrl
        price = networkModel.price
        explicitness = networkModel.explicitness
        trackCount = networkModel.trackCount
        country = networkModel.country
        currency = networkModel.currency
        releaseDate = networkModel.releaseDate
        primaryGenreName = networkModel.primaryGenreName
    }
}
