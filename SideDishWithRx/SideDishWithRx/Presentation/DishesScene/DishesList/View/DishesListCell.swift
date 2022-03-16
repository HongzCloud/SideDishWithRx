//
//  DishesListCell.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/10.
//

import UIKit
import RxCocoa

class DishesListCell: UITableViewCell {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitle: UILabel!
    @IBOutlet weak var dishDescription: UILabel!
    @IBOutlet weak var dishPriceStackView: UIStackView!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    override func prepareForReuse() {
        self.dishTitle.text = ""
        self.dishDescription.text = ""
        self.dishImageView.image = UIImage()
        self.dishPriceStackView.subviews.forEach { views in
            views.removeFromSuperview()
        }
        self.badgeStackView.subviews.forEach { views in
            views.removeFromSuperview()
        }
    }
    
    func fill(title: String, description: String, nPrice: String?, sPrice: String, badgeList: [BadgeType]?) {
        self.dishTitle.text = title
        self.dishDescription.text = description
        
        let priceView = PriceView()
        priceView.configSPriceLabel(sPrice)
        if let nPrice = nPrice {
            priceView.configNPriceLabel(nPrice)
        }
     
        dishPriceStackView.addArrangedSubview(priceView)
        
        if let badgeList = badgeList {
            badgeList.forEach { badge in
                let badgeView = BadgeView()
                badgeView.configBadge(badge)
                self.badgeStackView.addArrangedSubview(badgeView)
            }
        }
    }
}
