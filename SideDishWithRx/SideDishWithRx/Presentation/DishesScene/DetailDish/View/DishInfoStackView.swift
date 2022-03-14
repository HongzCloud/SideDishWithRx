//
//  DishInfoStackView.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/03/14.
//

import UIKit

final class DishInfoStackView: UIStackView {
    
    func addArrangedImageView(_ image: UIImage, newWidth: CGFloat) {
        let resizeImage = image.resize(newWidth: newWidth)
        
        let imageView = UIImageView(image: resizeImage)
        imageView.contentMode = .scaleAspectFill
        
        self.addArrangedSubview(imageView)
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
