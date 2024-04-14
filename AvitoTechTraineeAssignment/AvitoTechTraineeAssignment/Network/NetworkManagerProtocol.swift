//
//  NetworkManagerProtocol.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 13.04.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func loadArtist(with queryItems: [URLQueryItem], completion: @escaping (Result<ArtistDescription, Error>) -> Void)
        func fetchItems(with queryItems: [URLQueryItem], completion: @escaping (Result<[Item], Error>) -> Void)
}
