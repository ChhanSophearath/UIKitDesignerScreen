//
//  GotoTabBarController.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 2/2/24.
//

import Foundation
import UIKit


func gotoTabBarController(){
    let newViewController = CustomTabBarVC()
    let navi = UINavigationController(rootViewController: newViewController)
    customTabView.collectionView.selectItem(at:IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    
    //MARK: Set blur before show
    let transition = CATransition()
    transition.type = CATransitionType.fade
    transition.duration = 0.3
    UIApplication.shared.windows.first?.layer.add(transition, forKey: kCATransition)
    
    UIApplication.shared.windows.first?.rootViewController = navi
    UIApplication.shared.windows.first?.makeKeyAndVisible()
}

