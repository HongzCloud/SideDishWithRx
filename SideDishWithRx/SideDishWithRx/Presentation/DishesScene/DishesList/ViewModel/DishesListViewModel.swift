//
//  DishesListViewModel.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/27.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol DishesListViewModelInput {
    func viewDidLoad()
}

protocol DishesListViewModelOutput {
    var items: PublishRelay<[DishesListItemViewModel]> { get }
}

protocol DishesListViewModel: DishesListViewModelInput, DishesListViewModelOutput {}

final class DefaultDishesListViewModel: DishesListViewModel {
    
    // MARK: - Output
    
    var items: PublishRelay<[DishesListItemViewModel]> = PublishRelay<[DishesListItemViewModel]>()

    private let searchDishesUseCase: SearchDishesUseCase
    private var disposeBag = DisposeBag()
    
    // MARK: - Init

    init(searchDishesUseCase: SearchDishesUseCase) {
        self.searchDishesUseCase = searchDishesUseCase
    }

    func load() {

        searchDishesUseCase.executet(requestValue: .init(dishTypeList: [.main, .side, .soup]))
            .map { dishes -> [DishesListItemViewModel] in
                let dishes = [
                DishesListItemViewModel(header: SectionOfDishes.main.header, items: dishes[0]),
                DishesListItemViewModel(header: SectionOfDishes.side.header, items: dishes[1]),
                DishesListItemViewModel(header: SectionOfDishes.soup.header, items: dishes[2]),
                ]
                return dishes
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
}

// MARK: - Input

extension DefaultDishesListViewModel {
    func viewDidLoad() {
        load()
    }
}

struct DishesListItemViewModel {
    let header: String
    let items: [Dish]
}
