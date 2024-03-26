//
//  SwipingItemsVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 14/2/24.
//

import UIKit

class SwipingItemsVC: UIViewController {

    let containerScroll = UIScrollView()

        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupView()
        }
        
    
    func setupView(){
        containerScroll.backgroundColor = .systemPink
        containerScroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerScroll)
        
        NSLayoutConstraint.activate([
        
            containerScroll.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerScroll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerScroll.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            containerScroll.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        
        
        
        ])
        
        
        
    }
    

    }
