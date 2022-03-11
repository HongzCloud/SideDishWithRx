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
    
    // Output
    let items: PublishRelay<DetailDishItemViewModel>
    
    private var disposeBag = DisposeBag()
    private var fetchDetailDishUseCase: FetchDetailDishUseCase
    private var dish: Dish
    
    init(fetchDetailDishUseCase: FetchDetailDishUseCase, dish: Dish) {
        self.fetchDetailDishUseCase = fetchDetailDishUseCase
        self.items = PublishRelay<DetailDishItemViewModel>()
        self.dish = dish
        load(hash: dish.detailHash)
    }
    
    func load(hash: String) {
        fetchDetailDishUseCase.execute(requestValue: .init(hash: hash))
            .map{ dishInfo in
                DetailDishItemViewModel(topImage: dishInfo.topImage)
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
}

struct DetailDishItemViewModel {
    let topImage: String
}

extension DefaultDetailDishViewModel {
    // Input
    func viewDidLoad() {
    }
}
