//
//  BadgeView.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/10.
//

import UIKit

class BadgeView: UIView {
    
    private var badgeStackView: UIStackView = {
        var badgeStackView = UIStackView()
        badgeStackView.translatesAutoresizingMaskIntoConstraints = false
        return badgeStackView
    }()
    
    private var emptyView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var emptyView2: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var badgeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
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

    override func layoutSubviews() {
      super.layoutSubviews()
      self.layer.cornerRadius = self.frame.height / 4.0
    }
    
    private func setUIObjects() {
        setBadgeStackView()
        setEmptyView()
        setEmptyView2()
        self.clipsToBounds = true
    }
    
    private func setBadgeStackView() {
        self.addSubview(badgeStackView)
        NSLayoutConstraint.activate([
            badgeStackView.topAnchor.constraint(equalTo: self.topAnchor),
            badgeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            badgeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            badgeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        badgeStackView.addArrangedSubview(emptyView)
        badgeStackView.addArrangedSubview(badgeLabel)
        badgeStackView.addArrangedSubview(emptyView2)
    }
    
    private func setEmptyView() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: self.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            emptyView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func setEmptyView2() {
        NSLayoutConstraint.activate([
            emptyView2.topAnchor.constraint(equalTo: self.topAnchor),
            emptyView2.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            emptyView2.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func configBadge(_ text: String) {
        self.badgeLabel.text = text
        
        switch text {
        case BadgeType.main.rawValue:
            self.backgroundColor = .yellow
        case BadgeType.event.rawValue:
            self.backgroundColor = .green
        case BadgeType.launching.rawValue:
            self.backgroundColor = .cyan
        default:
            break
        }
    }
}
