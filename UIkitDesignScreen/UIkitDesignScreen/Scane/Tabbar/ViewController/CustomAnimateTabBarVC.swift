//
//  CustomAnimateTabBarVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 8/2/24.
//

import UIKit

class CustomAnimateTabBarVC: UITabBarController {

    let pagingViewController =  PagingViewControoller()
    
    

    static  let homeVC =  UIkitDesignScreenVC1()
    static let googleMaps = UIkitDesignScreenVC2()
    static let rewards =  UIkitDesignScreenVC3()
    static let account =  UIkitDesignScreenVC4()
    
    
   @objc func UIkitDesignScreen(){
       let vc = UIkitDesignScreenVC5()
       self.pushViewController(vc)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        CustomAnimateTabBarVC.homeVC.button.addTarget(self, action: #selector(UIkitDesignScreen), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        addCustomTabBarView()
        didTappedTabbarCustom()
        setupPagingViewController()
    }
    
    
    private func didTappedTabbarCustom(){
        
        //MARK: didTapped on Tabbar custom
        customTabView.didSelectedRow = { [weak self] index in
            guard let self = self else { return }
            pagingViewController.changeControllerIndex = index
        }
        
        //MARK: didTapped on Button
        customTabView.didTappedScan = {
            DispatchQueue.main.async {
                let  vcOne =  UIkitDesignScreenVC1()
                self.navigationController?.pushViewController(vcOne, animated: true)
            }
        }
    }
    
    
    private func setupPagingViewController(){
        
        pagingViewController.addContentViewController(viewController: CustomAnimateTabBarVC.homeVC)
        pagingViewController.addContentViewController(viewController: CustomAnimateTabBarVC.googleMaps)
        pagingViewController.addContentViewController(viewController: CustomAnimateTabBarVC.rewards)
        pagingViewController.addContentViewController(viewController: CustomAnimateTabBarVC.account)
        self.addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.frame = view.bounds
    }
    
    
    private func addCustomTabBarView() {
        
        customTabView.bringSubviewToFront(self.tabBar)
        view.addSubview(customTabView)
        NSLayoutConstraint.activate([
            customTabView.heightAnchor.constraint(equalToConstant: 85),
            customTabView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            customTabView.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1),
            customTabView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
        ])
    }
}
