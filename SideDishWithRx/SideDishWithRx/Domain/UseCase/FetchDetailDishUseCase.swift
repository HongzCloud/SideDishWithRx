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
    
    private let detailDishRepository: DetailDishRepository
    
    init(detailDishRepository: DetailDishRepository) {
        self.detailDishRepository = detailDishRepository
    }
    
    func execute(requestValue: FetchDetailDishUseCaseRequestValue) -> Observable<DetailDishInfo>  {
        
        return detailDishRepository.fetchDishes(hash: requestValue.hash)
            .map{ ($0.data) }
    }
}

struct FetchDetailDishUseCaseRequestValue {
    var hash: String
}
