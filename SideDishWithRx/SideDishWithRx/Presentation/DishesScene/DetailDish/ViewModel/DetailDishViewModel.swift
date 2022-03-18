//
//  DetailDishViewModel.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailDishViewModelInput {
    func viewDidLoad()
}

protocol DetailDishViewModelOutput {
    var items: PublishRelay<DetailDishItemViewModel> { get }
}

protocol DetailDishViewModel: DetailDishViewModelInput, DetailDishViewModelOutput {}

final class DefaultDetailDishViewModel: DetailDishViewModel {
   
    private var disposeBag = DisposeBag()
    private var fetchDetailDishUseCase: FetchDetailDishUseCase
    private var dish: Dish
    
    // MARK: - Output
    
    let items: PublishRelay<DetailDishItemViewModel>
    
    // MARK: - Init
    
    init(fetchDetailDishUseCase: FetchDetailDishUseCase,
         dish: Dish) {
        
        self.fetchDetailDishUseCase = fetchDetailDishUseCase
        self.items = PublishRelay<DetailDishItemViewModel>()
        self.dish = dish
        load(hash: dish.detailHash)
    }

    func load(hash: String) {
        fetchDetailDishUseCase.execute(requestValue: .init(hash: hash))
            .map{ [weak self] dishInfo in
                
                DetailDishItemViewModel(title: self!.dish.title,
                                        thumbImages: dishInfo.thumbImages,
                                        productDescription: self!.dish.bodyDescription,
                                        point: dishInfo.point,
                                        deliveryFee: dishInfo.deliveryFee,
                                        deliverryInfo: dishInfo.deliveryInfo,
                                        nPrice: self!.dish.nPrice,
                                        sPrice: self!.dish.sPrice,
                                        productDetailImages: dishInfo.detailSection,
                                        badge: self?.dish.badge)
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
}

struct DetailDishItemViewModel {
    let title: String
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryFee: String
    let deliverryInfo: String
    let nPrice: String?
    let sPrice: String
    let productDetailImages: [String]
    let badge: [BadgeType]?
}

// MARK: - Input

extension DefaultDetailDishViewModel {
    func viewDidLoad() {        
    }
}
