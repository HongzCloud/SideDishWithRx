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
    func didTappedQuantityUpButton()
    func didTappedQuantityDownButton()
}

protocol DetailDishViewModelOutput {
    var items: PublishRelay<DetailDishItemViewModel> { get }
    var orderQuantity: BehaviorRelay<Int> { get }
    var orderPrice: BehaviorRelay<String> { get }
}

protocol DetailDishViewModel: DetailDishViewModelInput, DetailDishViewModelOutput {}

final class DefaultDetailDishViewModel: DetailDishViewModel {
   
    private var disposeBag = DisposeBag()
    private var fetchDetailDishUseCase: FetchDetailDishUseCase
    private var dish: Dish
    
    // MARK: - Output
    
    let items: PublishRelay<DetailDishItemViewModel>
    let orderQuantity: BehaviorRelay<Int>
    let orderPrice: BehaviorRelay<String>
    
    // MARK: - Init
    
    init(fetchDetailDishUseCase: FetchDetailDishUseCase,
         dish: Dish) {
        
        self.fetchDetailDishUseCase = fetchDetailDishUseCase
        self.items = PublishRelay<DetailDishItemViewModel>()
        self.dish = dish
        self.orderQuantity = BehaviorRelay<Int>(value: 1)
        self.orderPrice = BehaviorRelay<String>(value: "\(dish.sPrice)")
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
    func viewDidLoad() {}
    
    func didTappedQuantityUpButton() {
        orderQuantity.accept(orderQuantity.value+1)
        orderPrice.accept(calculateOrderPrice())
    }
    
    func didTappedQuantityDownButton() {
        if orderQuantity.value > 1 {
            orderQuantity.accept(orderQuantity.value-1)
            orderPrice.accept(calculateOrderPrice())
        }
    }
    
    // MARK: - Private
    
    private func calculateOrderPrice() -> String {
        let price = convertPriceToInt(dish.sPrice)
        let quantity = orderQuantity.value
        let totalPriceInt = price * quantity
        let totalPrice = convertPriceToString(totalPriceInt)
        
        return totalPrice
    }
    
    private func convertPriceToInt(_ price: String) -> Int {
        let price = Int(price.filter({ $0.isNumber }))
        return price ?? 0
    }
    
    private func convertPriceToString(_ price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return (numberFormatter.string(from: NSNumber(value: price)) ?? "") + " 원"
    }
}
