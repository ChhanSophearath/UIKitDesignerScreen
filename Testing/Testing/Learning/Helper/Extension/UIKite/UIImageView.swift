//
//  ChangeColors.swift
//  IQ
//
//  Created by Rath! on 2/2/24.
//

import Foundation
import UIKit
import SDWebImage


extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
}
 

extension UIImageView {
    
    func load(image path: String, placeholderImage: UIImage? = nil) {
        let url = URL(string: path)
        if url != nil {
            sd_imageIndicator?.indicatorView.isHidden = true
            sd_imageIndicator = SDWebImageActivityIndicator.white
        }else{
            sd_imageIndicator = nil
        }
        sd_setImage(with: url, placeholderImage: placeholderImage)
    }
    
}

