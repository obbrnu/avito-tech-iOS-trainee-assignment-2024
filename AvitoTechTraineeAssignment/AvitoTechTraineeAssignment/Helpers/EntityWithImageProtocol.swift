//
//  EntityWithImageProtocol.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation
import UIKit

protocol EntityWithImageProtocol {
    var imageUrl: String? { get }
    func getImageOf() -> UIImage
}

extension EntityWithImageProtocol {
    func getImageOf() -> UIImage{
        guard let imageUrl else {
            return UIImage(systemName: "photo.fill")!
        }
        let image = ImageCache.shared.getImage(with: imageUrl) ?? UIImage(systemName: "photo.fill")!
        return image
    }
}


