//
//  DetailDishViewController.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class DetailDishViewController: UIViewController {
    
    @IBOutlet weak var thumbnailScrollView: UIScrollView!
    @IBOutlet weak var dishInfoStackView: DishInfoStackView!
    
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var badgeLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var viewModel: DetailDishViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
    }

    func bind() {
        
        viewModel.items
            .compactMap({ $0.sPrice })
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { sPrice in
                let sPriceView = PriceView()
                sPriceView.configSPriceLabel(sPrice, fontSize: 20)
                self.priceStackView.addArrangedSubview(sPriceView)
            })
            .disposed(by: disposeBag)
        
        viewModel.items
            .compactMap({ $0.nPrice })
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { nPrice in
                let nPriceView = PriceView()
                nPriceView.configNPriceLabel(nPrice, fontSize: 18)
                self.priceStackView.addArrangedSubview(nPriceView)
            })
            .disposed(by: disposeBag)
        
        viewModel.items
            .map({ $0.badge })
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] badgeList in
                if badgeList == nil {
                    self.badgeLabelHeight.constant = 0
                    badgeStackView.isHidden = true
                } else {
                    badgeList?.forEach({ badge in
                        let badgeView = BadgeView()
                        badgeView.configBadge(badge)
                        self.badgeStackView.addArrangedSubview(badgeView)
                    })
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.items
            .map({ $0.title })
            .asDriver(onErrorJustReturn: "")
            .drive(dishTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.items
            .map({ $0.deliverryInfo })
            .asDriver(onErrorJustReturn: "")
            .drive(deliveryInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.items
            .map({ $0.point })
            .asDriver(onErrorJustReturn: "")
            .drive(pointLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.items
            .map({ $0.deliveryFee })
            .asDriver(onErrorJustReturn: "")
            .drive(deliveryFeeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.items
            .map({ $0.productDescription })
            .asDriver(onErrorJustReturn: "")
            .drive(productDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.items
            .concatMap { item in
                Observable<String>.from(item.thumbImages)
            }
            .observe(on: MainScheduler.instance)
            .compactMap({ URL(string: $0) })
            .enumerated()
            .do(onNext: { [weak self] (index: Int, imageURL: URL) in
                let imageView = UIImageView()
                imageView.kf.setImage(with: imageURL)
                self?.addThumbnail(index: index, imageView: imageView)
            })
            .subscribe()
            .disposed(by: disposeBag)
                
        viewModel.items
            .concatMap { item in
                Observable<String>.from(item.productDetailImages)
            }
            .observe(on: MainScheduler.instance)
            .compactMap({ URL(string: $0) })
            .enumerated()
            .do(onNext: { [weak self] (index: Int, imageURL: URL) in
                let newWidth = self!.view.bounds.width
                self!.dishInfoStackView.addArrangedImageView(imageURL,
                                                            newWidth: newWidth)
            })
            .subscribe()
            .disposed(by: disposeBag)
                
        viewModel.orderQuantity
            .asDriver(onErrorJustReturn: 1)
            .map({ String($0) })
            .drive(quantityLabel.rx.text)
            .disposed(by: disposeBag)
                
        viewModel.orderPrice
            .asDriver(onErrorJustReturn: "")
            .drive(orderPriceLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func addThumbnail(index: Int, imageView: UIImageView) {
        let xPosition = self.view.frame.width * CGFloat(index)
        let bounds = self.thumbnailScrollView.bounds
        
        imageView.frame = CGRect(x: xPosition, y: 0, width: bounds.width, height: bounds.height)
        
        self.thumbnailScrollView.contentSize.width = imageView.frame.width * CGFloat(index+1)
        self.thumbnailScrollView.addSubview(imageView)
    }
    @IBAction func didTappedQuantityUpButton(_ sender: Any) {
        viewModel.didTappedQuantityUpButton()
    }
    @IBAction func didTappedQuantityDownButton(_ sender: Any) {
        viewModel.didTappedQuantityDownButton()
    }
}
