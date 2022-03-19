//
//  SearchDishesUseCase.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/27.
//

import Foundation
import RxSwift

protocol SearchDishesUseCase {
    func execute(requestValue: SearchDishesUseCaseRequestValue) -> Observable<[[Dish]]>
}

final class DefaultSearchDishesUseCase: SearchDishesUseCase {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func execute(requestValue: SearchDishesUseCaseRequestValue) -> Observable<[[Dish]]>  {
        
        return Observable.zip(
            requestValue.dishTypeList.map { path -> Observable<Dishes> in
                let endpoint = APIEndpoints.getDishes(path: path)
                return networkManager.request(endpoint: endpoint)
            }
        ).map { dishesList in
            dishesList.map { dishes in
                dishes.body
            }
        }
    }
}

struct SearchDishesUseCaseRequestValue {
    var dishTypeList: [Endpoint<RequesteResponsable>.Path]
}
