//
//  AppDIContainer.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import UIKit

final class AppDIContainer {
    
    // MARK: - Coordinator
    
    func makeAppFlowCoordinator(navigationController: UINavigationController) -> AppFlowCoordinator {
        return AppFlowCoordinator(navigationController: navigationController,
                                  appDIContainer: self)
    }
    
    // MARK: - DIContainer
    
    func makeDishesSceneDIContrainer() -> DishesSceneDIContrainer {
        return DishesSceneDIContrainer()
    }
}
