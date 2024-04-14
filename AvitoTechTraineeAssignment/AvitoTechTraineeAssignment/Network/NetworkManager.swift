//
//  NetworkManager.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//

import Foundation
import UIKit

final class NetworkManager {
     
    private let session: URLSession
    private let httpStatusCodeSuccess = 200..<300
    
    static let shared = NetworkManager()
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkManager: NetworkManagerProtocol {
    
    func fetchItems(with queryItems: [URLQueryItem], completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = getUrl(path: "/search", with: queryItems) else {
            completion(.failure(NetworkErrors.wrongUrl))
            return
        }
        
        Task { @MainActor in
            var flag = true
            var fetchedItems: [Item] = []
            let allImages = await withTaskGroup(of: (String, UIImage)?.self,
                                                returning: [String: UIImage].self,
                                                body: { [weak self] taskGroup in
                guard let self else {
                    return [:]
                }
                
                let result = await self.loadItems(from: url)
                switch result {
                case .success(let itemDesription):
                    for item in itemDesription.results {
                        var imageUrl: String?
                        switch item {
                        case .song(let description):
                            imageUrl = description.imageUrl
                            fetchedItems.append(Song(networkModel: description).eraseToItem())
                        case .album(let description):
                            imageUrl = description.imageUrl
                            fetchedItems.append(Album(networkModel: description).eraseToItem())
                        case .movie(let description):
                            imageUrl = description.imageUrl
                            fetchedItems.append(Movie(networkModel: description).eraseToItem())
                        case .audiobook(let description):
                            imageUrl = description.imageUrl
                            fetchedItems.append(Audiobook(networkModel: description).eraseToItem())
                        case .artist(_):
                            print("artist")
                        }
                        
                        if let imageUrl {
                            taskGroup.addTask {
                                let imageResult = await self.loadImage(from: imageUrl)
                                switch imageResult {
                                case .success(let image):
                                    return (imageUrl, image)
                                case .failure(_):
                                    return nil
                                }
                            }
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                    flag = false
                }
                
                var childTaskResults: [String: UIImage] = [:]
                for await result in taskGroup {
                    if let result {
                        childTaskResults[result.0] = result.1
                    }
                }
                return childTaskResults
            })
            
            for (key, value) in allImages {
                ImageCache.shared.saveImage(image: value, with: key)
            }
            
            if flag {
                completion(.success(fetchedItems))
            }
        }
    }
    
    private func loadItems(from url: URL) async -> Result<ItemDescription, Error>{
        do {
            let (data, response) = try await session.data(from: url)
            guard let response = response as? HTTPURLResponse else {
                return .failure(NetworkErrors.failedResponse)
            }
            guard httpStatusCodeSuccess.contains(response.statusCode) else {
                return .failure(NetworkErrors.unexpectedResponse)
            }
            let items = try JSONDecoder().decode(ItemDescription.self, from: data)
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
    
    private func loadImage(from url: String) async -> Result<UIImage, Error> {

        if let image = ImageCache.shared.getImage(with: url) {
            return .success(image)
        }
        
        guard let currentUrl = URL(string: url) else {
            return .failure(NetworkErrors.wrongUrl)
        }
        
        do {
            let (data, response) = try await session.data(from: currentUrl)
            guard let response = response as? HTTPURLResponse else {
                return .failure(NetworkErrors.failedResponse)
            }
            guard httpStatusCodeSuccess.contains(response.statusCode) else {
                return .failure(NetworkErrors.unexpectedResponse)
            }
            guard let image = UIImage(data: data) else {
                return .failure(NetworkErrors.wrongData)
            }
            return .success(image)
        } catch {
            return .failure(error)
        }
    }
    
    func loadArtist(with queryItems: [URLQueryItem], completion: @escaping (Result<ArtistDescription, Error>) -> Void) {
        
        guard let url = getUrl(path: "/lookup",with: queryItems) else {
            completion(.failure(NetworkErrors.wrongUrl))
            return
        }

        Task { @MainActor in
            let result = await self.loadItems(from: url)
            switch result {
            case .success(let artistDesription):
                for item in artistDesription.results {
                    switch item {
                    case .artist(let artist):
                        completion(.success(artist))
                    default:
                        completion(.failure(NetworkErrors.failedFetch))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getUrl(path: String, with queryItems: [URLQueryItem]) -> URL? {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            return nil
        }

        return url
    }
    
}
