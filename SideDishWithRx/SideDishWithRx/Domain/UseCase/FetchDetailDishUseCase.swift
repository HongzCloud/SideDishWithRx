//
//  FetchDetailDishUseCase.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import Foundation
import RxSwift

protocol FetchDetailDishUseCase {
    func execute(requestValue: FetchDetailDishUseCaseRequestValue) -> Observable<DetailDishInfo>
}

final class DefaultFetchDetailDishUseCase: FetchDetailDishUseCase {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func execute(requestValue: FetchDetailDishUseCaseRequestValue) -> Observable<DetailDishInfo>  {
        
        let endpoint = APIEndpoints.getDetailDish(hash: requestValue.hash)
        return networkManager.request(endpoint: endpoint)
        .map{ ($0.data) }
    }
}

struct FetchDetailDishUseCaseRequestValue {
    var hash: String
}
