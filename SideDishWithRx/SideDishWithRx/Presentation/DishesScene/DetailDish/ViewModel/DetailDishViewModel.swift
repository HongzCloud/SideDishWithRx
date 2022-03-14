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
    var items: PublishSubject<DetailDishItemViewModel> { get }
    var thumbnailImages: PublishRelay<Data> { get }
    var dishInfoImagees: PublishRelay<Data> { get }
}

protocol DetailDishViewModel: DetailDishViewModelInput, DetailDishViewModelOutput {}

final class DefaultDetailDishViewModel: DetailDishViewModel {
   
    private var disposeBag = DisposeBag()
    private var fetchDetailDishUseCase: FetchDetailDishUseCase
    private var imageRepository: ImageRepository
    private var dish: Dish
    
    // MARK: - Output
    
    let items: PublishSubject<DetailDishItemViewModel>
    let thumbnailImages: PublishRelay<Data>
    let dishInfoImagees: PublishRelay<Data>
    
    // MARK: - Init
    
    init(fetchDetailDishUseCase: FetchDetailDishUseCase,
         dish: Dish,
         imageRepository: ImageRepository = ImageRepository()) {
        
        self.fetchDetailDishUseCase = fetchDetailDishUseCase
        self.items = PublishSubject<DetailDishItemViewModel>()
        self.dish = dish
        self.thumbnailImages = PublishRelay<Data>()
        self.dishInfoImagees = PublishRelay<Data>()
        self.imageRepository = imageRepository
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
                                        nPrice: dishInfo.prices.first!,
                                        sPrice: self?.dish.sPrice,
                                        productDetailImages: dishInfo.detailSection)
            }
            .bind(to: items)
            .disposed(by: disposeBag)
        
        items
            .flatMap { item in
                Observable<String>.from(item.thumbImages)
            }
            .concatMap { [unowned self] in
                self.imageRepository.load(from: $0)
            }
            .bind(to: thumbnailImages)
            .disposed(by: disposeBag)
        
        items
            .flatMap { item in
                Observable<String>.from(item.productDetailImages)
            }
            .concatMap { [unowned self] in
                self.imageRepository.load(from: $0)
            }
            .bind(to: dishInfoImagees)
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
    let nPrice: String
    let sPrice: String?
    let productDetailImages: [String]
}

// MARK: - Input

extension DefaultDetailDishViewModel {
    func viewDidLoad() {        
    }
}
