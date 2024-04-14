//
//  ItemDescription.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 12.04.2024.
//

import Foundation

struct ItemDescription: Decodable {
    let resultCount: Int
    let results: [ResultsDescription]
}
