//
//  DishInfoStackView.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/14.
//

import UIKit
import Kingfisher

final class DishInfoStackView: UIStackView {
    
    func addArrangedImageView(_ imageURL: URL, newWidth: CGFloat) {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        
        KingfisherManager.shared.retrieveImage(with: imageURL, completionHandler: { result in
            switch(result) {
            case .success(let imageResult):
                
                let newWidth = self.bounds.width
                let resized = imageResult.image.resize(newWidth: newWidth)
                imageView.image = resized
                
                self.addArrangedSubview(imageView)
                
            case .failure(let error):
                print(error)
            }
        })
    }
}
