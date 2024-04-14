//
//  ItemCollectionRouter.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import UIKit

final class ItemCollectionRouter {
    weak var viewController: UIViewController?
}

extension ItemCollectionRouter: ItemCollectionRouterInput {
    
    func openItemCard(with item: Item) {
        let context = ItemPageContext(item: item)
        
        let container = ItemPageContainer.assemble(with: context)
        container.viewController.view.backgroundColor = .white
        
        let backItem = UIBarButtonItem()
        backItem.title = "Search"
        viewController?.navigationItem.backBarButtonItem = backItem
        
        viewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
    
}
