//
//  ViewController.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/12.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let viewModel = DefaultDishesListViewModel(searchDishesUseCase: DefaultSearchDishesUseCase(dishesRepository: DefaultDishesRepository(networkManager: DefaultNetworkManager())))
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
    }
    
    func bind() {
        viewModel.items.subscribe { items in
            print(items)
        }.disposed(by: disposeBag)
    }
}

