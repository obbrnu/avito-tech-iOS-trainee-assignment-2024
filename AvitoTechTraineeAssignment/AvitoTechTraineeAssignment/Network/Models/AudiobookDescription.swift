//
//  AudiobookDescription.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 12.04.2024.
//

import Foundation

struct AudiobookDescription: Decodable {
    let wrapperType: String
    let artistId: Int64
    let id: Int64
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
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistId
        case id = "collectionId"
        case artistName
        case name = "collectionName"
        case viewUrl = "collectionViewUrl"
        case imageUrl = "artworkUrl100"
        case price = "collectionPrice"
        case explicitness = "collectionExplicitness"
        case country
        case currency
        case releaseDate
        case primaryGenreName
        case description
    }
}
