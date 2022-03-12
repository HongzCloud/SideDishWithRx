//
//  AppFlowCoordinator.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import UIKit

final class AppFlowCoordinator {
    
    private let navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let dishesSceneDIContainer = appDIContainer.makeDishesSceneDIContrainer()
        let flow = dishesSceneDIContainer.makeDishesSceneFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
