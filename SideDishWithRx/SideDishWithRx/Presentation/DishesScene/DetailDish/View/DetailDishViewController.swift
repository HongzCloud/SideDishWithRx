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
    
    var viewModel: DetailDishViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()
    }

    func bind() {
        
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
