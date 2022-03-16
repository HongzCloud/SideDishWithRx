//
//  DetailDishViewController.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/12.
//

import UIKit
import RxSwift
import RxCocoa

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
        
        viewModel.thumbnailImages
            .observe(on: MainScheduler.instance)
            .map({ UIImage(data: $0)})
            .map({ image -> UIImageView in
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                return imageView
            })
            .enumerated()
            .do(onNext: { [weak self] (index: Int, imageView: UIImageView) in
                self?.addThumbnail(index: index, imageView: imageView)
            })
            .subscribe()
            .disposed(by: disposeBag)
                
        viewModel.dishInfoImagees
            .observe(on: MainScheduler.instance)
            .compactMap({ UIImage(data: $0)})
            .subscribe(onNext: { [weak self] (image: UIImage) in
                let width = self?.dishInfoStackView.frame.width ?? 0
                self?.dishInfoStackView.addArrangedImageView(image, newWidth: width)
            })
            .disposed(by: disposeBag)
    }
    
    private func addThumbnail(index: Int, imageView: UIImageView) {
        let xPosition = self.view.frame.width * CGFloat(index)
        let bounds = self.thumbnailScrollView.bounds
        
        imageView.frame = CGRect(x: xPosition, y: 0, width: bounds.width, height: bounds.height)
        
        self.thumbnailScrollView.contentSize.width = imageView.frame.width * CGFloat(index+1)
        self.thumbnailScrollView.addSubview(imageView)
    }
}
