//
//  DishesSceneFlowCoordinator.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import Foundation
import UIKit

protocol DishesSceneFlowCoordinatorDependencies {
    func makeDishesListViewController(actions: DishesListViewModelAction) -> DishesListViewController
    func makeDetailDishViewController(dish: Dish) -> DetailDishViewController
}

final class DishesSceneFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private var dependencies: DishesSceneFlowCoordinatorDependencies
    
    init(navigationController: UINavigationController,
         dependencies: DishesSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = DishesListViewModelAction(showDetailDish: showDetailDish)
        let vc = dependencies.makeDishesListViewController(actions: actions)
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showDetailDish(dish: Dish) {
        let vc = dependencies.makeDetailDishViewController(dish: dish)
        navigationController?.pushViewController(vc, animated: true)
    }
}
