//
//  ItemPageContainer.swift
//  AvitoTechTraineeAssignment2024
//
//  Created by Александр Бобрун on 11.04.2024.
//
//

import UIKit

final class ItemPageContainer {
    let input: ItemPageModuleInput
    let viewController: UIViewController
    private(set) weak var router: ItemPageRouterInput!
    
    class func assemble(with context: ItemPageContext) -> ItemPageContainer {
        let router = ItemPageRouter()
        let interactor = ItemPageInteractor()
        let presenter = ItemPagePresenter(router: router, interactor: interactor, item: context.item)
        let viewController = ItemPageViewController(output: presenter, item: context.item)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ItemPageContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ItemPageModuleInput, router: ItemPageRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ItemPageContext {
    weak var moduleOutput: ItemPageModuleOutput?
    
    let item: Item
}
