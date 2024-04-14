//
//  ReusableCollection.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//

import Foundation
import UIKit

protocol ReusableCollectionCell: UICollectionViewCell {
    associatedtype Model: ReusableModel where Model.Cell == Self
    
    static var reusableIdentifier: String { get }
    
    func configure(with model: Model)
}

extension ReusableCollectionCell {
    
    static var reusableIdentifier: String {
        return NSStringFromClass(self)
    }
}
