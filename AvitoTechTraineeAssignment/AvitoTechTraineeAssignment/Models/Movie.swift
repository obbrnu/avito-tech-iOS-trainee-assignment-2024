//
//  movie.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//

import Foundation
import UIKit

struct Movie: ReusableModel, EntityWithImageProtocol, HTMLFormatterProtocol {
    
    typealias Cell = MovieCollectionViewCell
    typealias View = MovieInfoView
    
    let id: String
    let wrapperType: String
    let kind: String
    let artistId: Int64?
    let artistName: String
    let name: String
    let viewUrl: String
    let imageUrl: String?
    let price: Double?
    let releaseDate: String
    let explicitness: String
    let time: Int
    let country: String
    let currency: String?
    let primaryGenreName: String
    var shortDescription: String?
    var longDescription: String
    
    init(networkModel: MovieDescription) {
        id = String(networkModel.id)
        wrapperType = networkModel.wrapperType
        kind = networkModel.kind
        artistId = networkModel.artistId
        artistName = networkModel.artistName
        name = networkModel.name
        viewUrl = networkModel.viewUrl
        imageUrl = networkModel.imageUrl
        price = networkModel.price
        releaseDate = networkModel.releaseDate
        explicitness = networkModel.explicitness
        time = networkModel.time
        country = networkModel.country
        currency = networkModel.currency
        primaryGenreName = networkModel.primaryGenreName
        shortDescription = networkModel.shortDescription
        longDescription = networkModel.longDescription
        
        if let text = shortDescription {
            shortDescription = formate(text: text)
        }
        longDescription = formate(text: networkModel.longDescription)
    }
}
