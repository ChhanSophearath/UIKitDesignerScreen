//
//  SearchTransationVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 14/2/24.
//

import UIKit


let widthScreen =  UIScreen.main.bounds.width
let heightScreen =  UIScreen.main.bounds.height
let centerXScreen = widthScreen/2
let centerYScreen = heightScreen/2


class SearchTransationVC: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupButton()
    }
    
    private func setupButton(){
        let  buttonSearch  = UIButton()
        let x = (widthScreen - 30 )/15
        let y = heightScreen / 2
        let width = widthScreen - 30
        
        
        buttonSearch.addTarget(self, action: #selector(shareTransation), for: .touchUpInside)
        buttonSearch.setTitle("Searh", for: .normal)
        buttonSearch.backgroundColor = .orange
        buttonSearch.frame = CGRect(x: x, y: y, width: width, height: 50)
        view.addSubview(buttonSearch)
    }
    
    
    
 @objc  func shareTransation(){

        let width: CGFloat = view.frame.width
        let height: CGFloat = view.frame.height
        
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        let image = renderer.image { ctx in
            view.drawHierarchy(in: CGRect(x: 0, y: 0, width: width, height: height), afterScreenUpdates: true)
        }
        
       
        
//        let titleToShare = "thanks_for_nupheap_So".localized()
        let  items : [Any] = [image] // Add both text and image to the items array
        
        let activityViewController = UIActivityViewController(activityItems: items , applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            // Handle completion of sharing
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
//    func shareTransation(){
//
//        let width: CGFloat = headerViewTB.backgroundView.frame.width
//        let height: CGFloat = headerViewTB.backgroundView.frame.height
//        
//        
//        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
//        let image = renderer.image { ctx in
//            headerViewTB.backgroundView.drawHierarchy(in: CGRect(x: 0, y: 0, width: width, height: height), afterScreenUpdates: true)
//        }
//        
//       
//        
////        let titleToShare = "thanks_for_nupheap_So".localized()
//        let  items : [Any] = [image] // Add both text and image to the items array
//        
//        let activityViewController = UIActivityViewController(activityItems: items , applicationActivities: nil)
//        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
//            // Handle completion of sharing
//        }
//        
//        present(activityViewController, animated: true, completion: nil)
//    }

}
