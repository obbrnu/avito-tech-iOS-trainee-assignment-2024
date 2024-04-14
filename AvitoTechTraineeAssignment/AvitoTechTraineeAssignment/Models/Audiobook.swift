//
//  Audiobook.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//

import Foundation
import UIKit

struct Audiobook: ReusableModel, EntityWithImageProtocol, HTMLFormatterProtocol {
    
    typealias Cell = AudiobookCollectionViewCell
    typealias View = AudiobookInfoView
    
    let id: String
    let wrapperType: String
    let artistId: Int64?
    let artistName: String
    let name: String
    let viewUrl: String
    let imageUrl: String?
    let price: Double?
    let explicitness: String
    let country: String
    let currency: String?
    let releaseDate: String
    let primaryGenreName: String
    var description: String
        
    init(networkModel: AudiobookDescription) {
        id = String(networkModel.id)
        wrapperType = networkModel.wrapperType
        artistId = networkModel.artistId
        artistName = networkModel.artistName
        name = networkModel.name
        viewUrl = networkModel.viewUrl
        imageUrl = networkModel.imageUrl
        price = networkModel.price
        explicitness = networkModel.explicitness
        country = networkModel.country
        currency = networkModel.currency
        releaseDate = networkModel.releaseDate
        primaryGenreName = networkModel.primaryGenreName
        description = networkModel.description
    
        description = formate(text: networkModel.description)
    }
}
