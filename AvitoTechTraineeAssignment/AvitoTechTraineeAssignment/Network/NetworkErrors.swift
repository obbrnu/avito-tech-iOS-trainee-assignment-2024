//
//  NetworkErrors.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 13.04.2024.
//

import Foundation

enum NetworkErrors: Error {
    case wrongUrl
    case wrongData
    case failedResponse
    case unexpectedResponse
    case failedFetch
    case failedDataDecode
}
