//
//  AlbumDescription.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 12.04.2024.
//

import Foundation

struct AlbumDescription: Decodable {
    let wrapperType: String
    let collectionType: String
    let artistId: Int64
    let id: Int64
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
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case collectionType
        case artistId
        case id = "collectionId"
        case artistName
        case name = "collectionName"
        case viewUrl = "collectionViewUrl"
        case imageUrl = "artworkUrl100"
        case price = "collectionPrice"
        case explicitness = "collectionExplicitness"
        case trackCount
        case country
        case currency
        case releaseDate
        case primaryGenreName
    }
}
