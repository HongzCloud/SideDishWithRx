//
//  DishesSceneDIContrainer.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import Foundation
import UIKit

final class DishesSceneDIContrainer: DishesSceneFlowCoordinatorDependencies {
    
    // MARK: - UseCase
    
    func makeFetchDetailDishUseCase() -> SearchDishesUseCase {
        return DefaultSearchDishesUseCase(networkManager: DefaultNetworkManager())
    }
    
    func makeFetchDetailDishUseCase() -> FetchDetailDishUseCase {
        return DefaultFetchDetailDishUseCase(networkManager: DefaultNetworkManager())
    }
    
    // MARK: - ViewModel
    
    func makeDetailDishViewModel(dish: Dish) -> DetailDishViewModel {
        DefaultDetailDishViewModel(fetchDetailDishUseCase: makeFetchDetailDishUseCase(), dish: dish)
    }
    
    func makeDishesListViewModel(actions: DishesListViewModelAction ) -> DishesListViewModel {
        return DefaultDishesListViewModel(searchDishesUseCase: makeFetchDetailDishUseCase(), actions: actions)
    }
    
    // MARK: - ViewController
    
    func makeDishesListViewController(actions: DishesListViewModelAction) -> DishesListViewController {
        let storyboard = UIStoryboard(name: "DishesListViewController", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DishesListViewController") as? DishesListViewController
        vc?.viewModel = makeDishesListViewModel(actions: actions)
        return vc ?? DishesListViewController()
    }
    
    func makeDetailDishViewController(dish: Dish) -> DetailDishViewController {
        let storyboard = UIStoryboard(name: "DetailDishViewController", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailDishViewController") as? DetailDishViewController
        vc?.viewModel = makeDetailDishViewModel(dish: dish)
        return vc ?? DetailDishViewController()
    }
    
    // MARK: - Coordinator
    
    func makeDishesSceneFlowCoordinator(navigationController: UINavigationController) -> DishesSceneFlowCoordinator {
        return DishesSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
