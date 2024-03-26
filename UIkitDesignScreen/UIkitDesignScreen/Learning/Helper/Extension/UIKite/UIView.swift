//
//  UIView.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 2/2/24.
//

import Foundation
import UIKit

//MARK: Set corner radius
extension UIView{
    //corner top
    func topCorner(_ cornerRadius: CGFloat) -> Void {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    //corner bottom
    func bottomCorner(_ cornerRadius: CGFloat) -> Void {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    enum RoundCornersAt{
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }
    
    //multiple corners using CACornerMask
    func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [
            corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
            corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
            corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
            corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
        ]
    }
    //MARK: Example ===>  view.roundCorners(corners: [RoundCornersAt.topLeft], radius: 10)
}



//MARK: For push viewController in view
extension UIView{
    
    func viewContainingController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        return nil
    }
    //MARK: Example ===>  viewContainingController()...
}


//MARK: Set back scroll
extension UIView{
    
    func backScroll(_ scrollView: UIScrollView) {
        //when call func backScrollHorizontal need delegate UIScrollViewDelegate
        let delayInSeconds = 0.0 // wait timeter before when back scroll
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}


extension UIView{
    
    //MARK: Check divice screen
    func isFullScreen() -> Bool {
        let screenHeight = UIScreen.main.nativeBounds.height
        if screenHeight >= 2436 {
            return true
        } else {
            // Other devices including iPhone 6, 6s, 7, 8, SE (1st generation)
            return false
        }
    }
    
    //MARK: Check type iPhone or ipad
    func isiPhone() -> Bool{
        if UIDevice.current.userInterfaceIdiom == .phone{
            return true
        }else{
            return false
        }
    }
    
}

//MARK: Set background ImageView
extension UIView {
    
    func backgroundImageView( _ imageName: String){
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.image = UIImage(named: imageName)
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.sendSubviewToBack(imageView)
    }
    
}



//MARK: ShadowColor
extension UIView{
    
    func  shadowView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
    }
    
    func  shadowViewBottomAndRight(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.masksToBounds = false
    }
    
}


//MARK: Button on keyborad
extension UIView {
    private struct AssociatedKeys {
        static var keyboardWillShownClosure = "keyboardWillShownClosure"
        static var keyboardWillBeHiddenClosure = "keyboardWillBeHiddenClosure"
    }
    
    var keyboardWillShownClosure: (( _ height:  CGFloat) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.keyboardWillShownClosure) as? ( _ height:  CGFloat ) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.keyboardWillShownClosure, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var keyboardWillBeHiddenClosure: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.keyboardWillBeHiddenClosure) as? () -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.keyboardWillBeHiddenClosure, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShown(_ notification: Notification) {
        // Do something when keyboard is shown
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = -keyboardRectangle.height - 20
            
            // Call the closure if assigned
            keyboardWillShownClosure?(keyboardHeight)
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        keyboardWillBeHiddenClosure?()
    }
}



//MARK: Get width text label
extension UIView{
    func getTextWidth(text: String, font: UIFont) -> CGFloat {
        let nsString = text as NSString
        let size = nsString.size(withAttributes: [NSAttributedString.Key.font: font])
        return size.width
    }
    
    // Helper function to create an image from a color
   
}

//MARK: set color select items
extension UIView{
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
