//
//  ResultsDescription.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 13.04.2024.
//

import Foundation

enum ResultsDescription: Decodable {
    
    case song(SongDescription)
    case album(AlbumDescription)
    case audiobook(AudiobookDescription)
    case movie(MovieDescription)
    case artist(ArtistDescription)
}

extension ResultsDescription {
    
    enum CodingKeys: CodingKey {
        case wrapperType
        case kind
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .wrapperType)
        let singleContainer = try decoder.singleValueContainer()
        
        switch type {
        case "track":
            let kind = try container.decode(String.self, forKey: .kind)
            switch kind {
            case "song":
                self = .song(try singleContainer.decode(SongDescription.self))
            case "feature-movie":
                self = .movie(try singleContainer.decode(MovieDescription.self))
            default:
                // for other types
                try self.init(from: decoder)
            }
        case "collection":
            self = .album(try singleContainer.decode(AlbumDescription.self))
        case "audiobook":
            self = .audiobook(try singleContainer.decode(AudiobookDescription.self))
        case "artist":
            self = .artist(try singleContainer.decode(ArtistDescription.self))
        default:
            // for other types
            try self.init(from: decoder)
        }
    }
}
