//
//  PageVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 9/2/24.
//

import UIKit

class PageVC: UIViewController {
    
    
    let paging = PagingVC()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurePaging()
    }
    

    private func configurePaging(){
        paging.addContentViewController(viewController: UIkitDesignScreenVC1())
        paging.addContentViewController(viewController: UIkitDesignScreenVC2())
        paging.addContentViewController(viewController: UIkitDesignScreenVC3())
        paging.addContentViewController(viewController: UIkitDesignScreenVC4())
        paging.addContentViewController(viewController: UIkitDesignScreenVC5())
        
        
        self.addChild(paging)
        view.addSubview(paging.view)
        paging.didMove(toParent: self)
        paging.view.frame = view.bounds.offsetBy(dx: 0, dy: 100)
        
    }

}
