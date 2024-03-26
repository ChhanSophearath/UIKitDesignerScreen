//
//  UILabel.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 2/2/24.
//

import Foundation
import UIKit
import Localize_Swift

extension UILabel{
    
    func fontExtraBold(_ size: CGFloat ){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name:  "NotoSansKhmerCondensed-ExtraBold"  , size: size)
        }else{
            self.font = UIFont(name: "NotoSansKhmerCondensed-ExtraBold"  , size: size)
        }
    }
    
    func fontLight(_ size: CGFloat ){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name:  "NotoSansKannada-Light"  , size: size)//"SF-Pro-Text-Medium"
        }else{
            self.font = UIFont(name: "NotoSansKannada-Light"  , size: size)
        }
    }
    
    func fontMedium(_ size: CGFloat ){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name:  "SFProText-Medium"  , size: size)//"SF-Pro-Text-Medium"
        }else{
            self.font = UIFont(name: "NotoSansKhmer-Medium"  , size: size)
        }
    }
    
    
    func fontBold(_ size: CGFloat){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name: "SFProText-Bold" , size: size)
        }else{
            self.font = UIFont(name: "NotoSansKhmer-Bold"  , size: size)
        }
    }
    
    func fontRegular(_ size: CGFloat){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name: "SFProText-Regular"  , size: size)
        }else{
            self.font = UIFont(name: "NotoSansKhmer-Regular"  , size: size)
        }
    }
    
    func fontSemiBold(_ size: CGFloat ){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name: "SFProText-Semibold"  , size: size)
        }else{
            self.font = UIFont(name: "NotoSansKhmer-SemiBold"  , size: size)
        }
    }
    
    func fontKanitSemiBold(_ size: CGFloat ){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name: "Kanit-SemiBold"  , size: size)
        }else{
            self.font = UIFont(name: "NotoSansKhmer-SemiBold"  , size: size)
        }
    }
    func fontKanitRegular(_ size: CGFloat ){
        if  Localize.currentLanguage() == "en"{
            self.font = UIFont(name: "Kanit-Regular"  , size: size)
        }else{
            self.font = UIFont(name: "NotoSansKhmer-SemiBold"  , size: size)
        }
    }
}


//MARK: Shadow textColor
extension UILabel{
    func  ShadowTextColor(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
    }
}
