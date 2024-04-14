//
//  ImageCacheProtocol.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func getImage(with url: String) -> UIImage?
    func saveImage(image: UIImage, with url: String)
}
