//
//  DetailDishRepository.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import Foundation
import RxSwift

protocol DetailDishRepository {
    func fetchDetailDish(hash: String) -> Observable<DetailDish>
}

final class DefaultDetailDishRepository: DetailDishRepository {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchDetailDish(hash: String) -> Observable<DetailDish> {
        let endpoint = APIEndpoints.getDetailDish(hash: hash)
        return networkManager.request(endpoint: endpoint)
    }

}
