//
//  UIImageView.swift
//  IQ
//
//  Created by Rath! on 2/2/24.
//

import Foundation
import UIKit


extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
 

