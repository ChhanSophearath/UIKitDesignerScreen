//
//  UIViewController.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 2/2/24.
//

import Foundation
import UIKit
import Localize_Swift

extension UIViewController{
    
    //MARK: Push viewController
    func pushViewController(_ viewController: UIViewController ){
        self.navigationController?.pushViewController(viewController , animated: true)
    }
    
    //MARK: Pop viewController
    @objc  func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Pop viewController
    @objc  func dismiss() {
        self.navigationController?.dismiss(animated: true)
    }
    
    //MARK: Push viewController do not back
    func pushDoNotBack(VC: UIViewController) {
        let navigationController = UINavigationController(rootViewController: VC)
        
        //MARK: Set blur before show
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5
        UIApplication.shared.windows.first?.layer.add(transition, forKey: kCATransition)
        
        //---
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}


extension UIViewController{
    
    //MARK: Default back viewController iOS
    func defaultNavigationBar(title: String){
        navigationController?.navigationBar.isHidden = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        if Localize.currentLanguage() == "en"{
            titleLabel.font = UIFont(name: "SFProText-Semibold", size: 17)
        }else{
            titleLabel.font = UIFont(name: "NotoSansKhmer-SemiBold", size: 17)
        }
        
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.topItem?.title = "";
        navigationController?.navigationBar.tintColor = .red
    }
    
    
    //MARK: Custom default back viewController
    func customNavigationBar(title: String,_ icRight: String?, _ evenBtnRight: Selector?){
        navigationController?.navigationBar.isHidden = false
        //set background color
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        // set title font
        var  font = UIFont.systemFont(ofSize: 17)
        
        if  Localize.currentLanguage() == "en"{
            font = UIFont(name:  "SFProText-Medium"  , size: 17) ?? UIFont.systemFont(ofSize: 17)
        }else{
            font = UIFont(name: "NotoSansKhmer-SemiBold"  , size: 17) ?? UIFont.systemFont(ofSize: 17)
        }
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: font
        ]
        
        //set title back = ""
        navigationController?.navigationBar.topItem?.title = "";
        
        //set color left
        navigationController?.navigationBar.tintColor = .red
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.fontSemiBold(17)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: icRight ?? "") ,
            style: .plain,
            target: self,
            action: evenBtnRight
        )
    }
}





import UIKit

class ToolbarView: UIView {
     var textField = UITextField()
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupToolbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupToolbar()
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField )
        
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        let toolbar = UIToolbar()
        toolbar.items = [flexibleSpace, doneButton]
        toolbar.sizeToFit()
        
        addSubview(toolbar)
    }
    
    @objc private func doneButtonTapped() {
        textField.resignFirstResponder()
    }
}
