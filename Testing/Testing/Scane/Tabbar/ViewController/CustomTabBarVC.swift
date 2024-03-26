//
//  CustomTabBarVC.swift
//  MerChantAPP
//
//  Created by Rath! on 21/12/23.
//

import UIKit

var customTabView: CustomTabBarView = {
    let view = CustomTabBarView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    return view
}()

class CustomTabBarVC: UITabBarController {
    
    //MARK: Currently using tabbar animate
    
    
    //MARK: For single view tabbar (For animte) (if else)
    let pagingViewController =  PagingViewControoller()
    
    
    //MARK: For single view tabbar (No animate) (else)
    //    var homeVC =  ViewController()
    //    var googleMaps = TestingVC2()
    //    var rewards =  TestingVC3()
    //    var account =  TestingVC4()
    
    
    //MARK: For mutiple view tabbar view tabbar (else)
    var homeVC = UINavigationController(rootViewController: ListViewController())
    var googleMaps = UINavigationController(rootViewController: TestingVC2())
    var rewards = UINavigationController(rootViewController: TestingVC3())
    var account = UINavigationController(rootViewController: TestingVC4())
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        //MARK: table viewController
        self.viewControllers = [homeVC, googleMaps, rewards, account]
        
        addCustomTabBarView()
        didTappedTabbarCustom()
        
        
        //        setupPagingViewController()
        
        
        
    }
    
    
    private func didTappedTabbarCustom(){
        
        //MARK: didTapped on Tabbar custom
        customTabView.didSelectedRow = { [weak self] index in
            guard let self = self else { return }
            self.selectedIndex = index
            //            pagingViewController.changeControllerIndex = index
        }
        
        
        //MARK: didTapped on Button
        customTabView.didTappedScan = {
            DispatchQueue.main.async {
                let  vcOne =  TestingVC1()
                self.navigationController?.pushViewController(vcOne, animated: true)
            }
        }
        
    }
    
    
    private func setupPagingViewController(){
        
        
        pagingViewController.addContentViewController(viewController: ViewController())
        pagingViewController.addContentViewController(viewController: TestingVC2())
        pagingViewController.addContentViewController(viewController: TestingVC3())
        pagingViewController.addContentViewController(viewController: TestingVC4())
        self.addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.frame = view.bounds
    }
    
    
    private func addCustomTabBarView() {
        //        customTabView.btnButtonTabbr.isHidden = true
        //        customTabView.bringSubviewToFront(self.tabBar)
        print("height tabbar: ", tabBar.frame.height)
        
        view.addSubview(customTabView)
        NSLayoutConstraint.activate([
            customTabView.heightAnchor.constraint(equalToConstant: 85),
            customTabView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            customTabView.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1),
            customTabView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
        ])
    }
}





