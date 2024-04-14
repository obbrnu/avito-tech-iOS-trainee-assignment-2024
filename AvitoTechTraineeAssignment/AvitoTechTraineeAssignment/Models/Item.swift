//
//  File.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//

import Foundation
import UIKit

extension ReusableModel {
    
    func eraseToItem() -> Item {
        return Item(model: self)
    }
}

struct Item {
    
    let reusableIdentifier: String
    let model: any ReusableModel
    let configurationCell: (UICollectionViewCell) -> Void
    let configurationView: () -> any ConformingView
    let cellType: any ReusableCollectionCell.Type
    
    init<M: ReusableModel>(model: M) {
        self.model = model
        self.reusableIdentifier = M.Cell.reusableIdentifier
        
        configurationCell = { cell in
            guard let reusableCell = cell as? M.Cell else {
                fatalError("\(#function) error cast")
            }
            reusableCell.configure(with: model)
        }
        
        configurationView = {
            let view = M.View()
            view.configure(with: model)
            return view
        }
        
        self.cellType = model.cellType
    }
    
}
