//
//  UIImage+Resize.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/19.
//

import UIKit
import Kingfisher

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

