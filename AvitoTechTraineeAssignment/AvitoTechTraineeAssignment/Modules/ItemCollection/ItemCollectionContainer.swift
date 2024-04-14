//
//  ItemCollectionContainer.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import UIKit

final class ItemCollectionContainer {
    let input: ItemCollectionModuleInput
    let viewController: UIViewController
    private(set) weak var router: ItemCollectionRouterInput!
    
    class func assemble(with context: ItemCollectionContext) -> ItemCollectionContainer {
        let router = ItemCollectionRouter()
        let interactor = ItemCollectionInteractor()
        let presenter = ItemCollectionPresenter(router: router, interactor: interactor)
        let viewController = ItemCollectionViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.viewController = viewController
        
        return ItemCollectionContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ItemCollectionModuleInput, router: ItemCollectionRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ItemCollectionContext {
    weak var moduleOutput: ItemCollectionModuleOutput?
}
