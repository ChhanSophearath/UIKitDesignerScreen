//
//  UIkitDesignScreenVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 1/2/24.
//

import Foundation
import UIKit

class UIkitDesignScreenVC1: UIViewController{
    

    
    let button = UIButton(frame: CGRect(x: 0, y: 300, width: 300, height: 50))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "Hello One"
        button.backgroundColor = .red
        view.addSubview(button)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.barTintColor = .purple
    }

}

class UIkitDesignScreenVC2: UIViewController{
    
    let button = UIButton(frame: CGRect(x: 0, y: 300, width: 300, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Hello Two"
        button.backgroundColor = .red
        view.addSubview(button)
    }

}

class UIkitDesignScreenVC3: UIViewController{
    let button = UIButton(frame: CGRect(x: 0, y: 300, width: 300, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Hello Three"
        button.backgroundColor = .red
        view.addSubview(button)
        
    }

}


class UIkitDesignScreenVC4: UIViewController{
    
    let button = UIButton(frame: CGRect(x: 0, y: 300, width: 300, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Hello four"
        button.backgroundColor = .purple
        view.addSubview(button)
    }

}


class UIkitDesignScreenVC5: UIViewController, UIGestureRecognizerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Hello four"
        
    }

}







//class YourViewController: UIViewController, UITabBarControllerDelegate {
//    var tabBarController: UITabBarController!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Create your tab bar controller
//        tabBarController = UITabBarController()
//        tabBarController.delegate = self
//        
//        // Set the view controllers for the tab bar controller
//        let viewController1 = UIkitDesignScreenVC1()
//        let viewController2 = UIkitDesignScreenVC2()
//        let viewController3 = UIkitDesignScreenVC3()
//        let viewController4 = UIkitDesignScreenVC4()
//        tabBarController.viewControllers = [viewController1, viewController2, viewController3, viewController4]
//        
//        // Set the tab bar controller as the root view controller
//        self.view.addSubview(tabBarController.view)
//        self.addChild(tabBarController)
//        tabBarController.didMove(toParent: self)
//    }
//    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let fromView = tabBarController.selectedViewController?.view,
//              let toView = viewController.view else {
//            return
//        }
//        
//        UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseInOut], completion: nil)
//    }
//}



//class YourViewController: UIViewController, UITabBarControllerDelegate {
//    var customTabBarController: UITabBarController!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        // Create your tab bar controller
//        customTabBarController = UITabBarController()
//        customTabBarController.delegate = self
//        
//        // Set the view controllers for the tab bar controller
//        let viewController1 = UIkitDesignScreenVC1()
//        let viewController2 = UIkitDesignScreenVC2()
//        let viewController3 = UIkitDesignScreenVC3()
//        customTabBarController.viewControllers = [viewController1, viewController2, viewController3]
//        
//        // Set the tab bar controller as the root view controller
//        self.view.addSubview(customTabBarController.view)
//        self.addChild(customTabBarController)
//        customTabBarController.didMove(toParent: self)
//    }
//    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        guard let fromView = tabBarController.selectedViewController?.view,
//              let toView = viewController.view else {
//            return
//        }
//        
//        UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseInOut], completion: nil)
//    }
//}
