//
//  ReusableModel.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation

protocol ReusableModel {
    associatedtype Cell: ReusableCollectionCell where Cell.Model == Self
    associatedtype View: ConformingView where View.Model == Self
    
    var cellType: Cell.Type { get }
    var id: String { get }
    var artistId: Int64? { get }
}

extension ReusableModel {
    
    var cellType: Cell.Type {
        return Cell.self
    }
}

