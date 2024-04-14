//
//  MovieDescription.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 12.04.2024.
//

import Foundation

struct MovieDescription: Decodable {
    let wrapperType: String
    let kind: String
    let artistId: Int64?
    let id: Int64
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
    let shortDescription: String?
    let longDescription: String
    
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case kind
        case artistId
        case id = "trackId"
        case artistName
        case name = "trackName"
        case viewUrl = "trackViewUrl"
        case imageUrl = "artworkUrl100"
        case price = "trackPrice"
        case releaseDate
        case explicitness = "trackExplicitness"
        case time = "trackTimeMillis"
        case country
        case currency
        case primaryGenreName
        case shortDescription
        case longDescription
    }
}
