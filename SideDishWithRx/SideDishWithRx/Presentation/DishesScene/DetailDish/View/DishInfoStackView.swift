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
                    imageView.isHidden = true
                }
            })
    }
}

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in:  CGRect(origin: .zero, size: size))
        }
        
        return renderImage
    }
}

extension UIImageView {
    func setImage(imagePath: String) {
        if let imageURL = URL(string: imagePath) {
            self.kf.indicatorType = .activity
            let size = self.bounds.size
            let processor = DownsamplingImageProcessor(size: size)
            
            self.kf.setImage(with: imageURL,
                             options: [.processor(processor),
                                       .transition(.fade(0.5))])
        }
    }
}
