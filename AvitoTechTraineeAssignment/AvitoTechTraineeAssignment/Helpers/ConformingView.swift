//
//  ConformingView.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 14.04.2024.
//

import Foundation
import UIKit

protocol ConformingView: UIView {
    associatedtype Model: ReusableModel where Model.View == Self
    
    func configure(with model: Model)
}
