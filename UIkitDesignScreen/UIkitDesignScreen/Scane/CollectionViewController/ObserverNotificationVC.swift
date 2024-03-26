//
//  ObserverNotificationVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 14/2/24.
//

import UIKit

extension Notification.Name {
     static let addObserverNotificationCenter = Notification.Name("RefreshHomePage")
}

//NotificationCenter.default.post(name: NSNotification.Name.refreshGetUserInfoHomePage, object: nil)

class ObserverNotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupButton()
        NotificationCenter.default.addObserver(self, selector: #selector(printText), name: .addObserverNotificationCenter  , object: nil)
    }
    
    @objc func printText(){
        print("NotificationCenter default addObserver")
    }
    
    private func setupButton(){
        let  buttonCellObserver  = UIButton()
        let x = (widthScreen - 30 )/15
        let y = heightScreen / 2
        let width = widthScreen - 30
        
        buttonCellObserver.addTarget(self, action: #selector(funcObserver), for: .touchUpInside)
        buttonCellObserver.setTitle("Observer Print Text", for: .normal)
        buttonCellObserver.backgroundColor = .orange
        buttonCellObserver.frame = CGRect(x: x, y: y, width: width, height: 50)
        view.addSubview(buttonCellObserver)
    }

    @objc func funcObserver(){
        NotificationCenter.default.post(name: .addObserverNotificationCenter, object: nil)
    }
  

}


