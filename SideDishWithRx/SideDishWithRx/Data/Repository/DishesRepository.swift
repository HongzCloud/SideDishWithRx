//
//  DishesRepository.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/27.
//

import Foundation
import RxSwift

protocol DishesRepository {
    func fetchDishes(path: Endpoint<RequesteResponsable>.Path) -> Observable<Dishes>
}

final class DefaultDishesRepository: DishesRepository {

    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchDishes(path: Endpoint<RequesteResponsable>.Path) -> Observable<Dishes> {
        let endpoint = APIEndpoints.getDishes(path: path)
        return networkManager.request(endpoint: endpoint)
    }
}
