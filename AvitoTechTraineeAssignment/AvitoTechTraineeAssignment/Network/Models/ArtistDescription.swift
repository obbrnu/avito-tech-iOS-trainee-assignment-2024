//
//  ArtistDescription.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 13.04.2024.
//

import Foundation

struct ArtistDescription: Decodable {
    let wrapperType: String
    let artistName: String
    let artistLinkUrl: String
    let artistId: Int64
}
