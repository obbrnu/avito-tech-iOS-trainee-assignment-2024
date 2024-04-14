//
//  ImageCache.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation
import UIKit

final class ImageCache {
    
    private var cache: [String: UIImage]
    
    static let shared = ImageCache()
    
    private init() {
        cache = [:]
    }
}

extension ImageCache: ImageCacheProtocol {

    func getImage(with url: String) -> UIImage? {
        return cache[url]
    }
    
    func saveImage(image: UIImage, with url: String) {
        cache[url] = image
    }
}

//final class ImageCache {
//    private let cache: NSCache<NSString, UIImage>
//
//    static let shared = ImageCache()
//
//    private init() {
//        cache = NSCache<NSString, UIImage>()
//
//        cache.countLimit = Constants.maxImagesCount
//        cache.totalCostLimit = Constants.totalSize
//    }
//
//    private struct Constants {
//        static let maxImagesCount: Int = 250
//        static let totalSize: Int = 50 * 1024 * 1024 // 50 MB
//    }
//}
//
//extension ImageCache: ImageCacheProtocol {
//
//    func getImage(with url: String) -> UIImage? {
//        return cache.object(forKey: NSString(string: url))
//    }
//
//    func saveImage(image: UIImage, with url: String) {
//        cache.setObject(image, forKey: NSString(string: url))
//    }
//}
