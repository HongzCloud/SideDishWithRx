//
//  PriceView.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/11.
//

import UIKit

class PriceView: UIView {
    
    private var priceStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var nPriceLabel: UILabel = {
        var label = UILabel()
       return label
    }()
    
    private var sPriceLabel: UILabel = {
        var label = UILabel()
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUIObjects()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUIObjects()
    }
    
    private func setUIObjects() {
        setPriceStackView()
    }
    
    private func setPriceStackView() {
        self.addSubview(priceStackView)
        NSLayoutConstraint.activate([
            priceStackView.topAnchor.constraint(equalTo: self.topAnchor),
            priceStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configNPriceLabel(_ nPrice: String) {
        nPriceLabel.text = nPrice
        nPriceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        priceStackView.addArrangedSubview(nPriceLabel)
    }
    
    func configSPriceLabel(_ sPrice: String) {
        sPriceLabel.text = sPrice
        sPriceLabel.font = UIFont.systemFont(ofSize: 16)
        sPriceLabel.textColor = .systemGray
        
        if let text = sPriceLabel.text {
            let attributeString = NSMutableAttributedString(string: text)

            attributeString.addAttribute(.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: NSMakeRange(0, attributeString.length))

            sPriceLabel.attributedText = attributeString
        }
      
        priceStackView.addArrangedSubview(sPriceLabel)
    }
}
