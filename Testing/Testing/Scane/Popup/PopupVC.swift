//
//  PopupVC.swift
//  IQ
//
//  Created by Rath! on 9/2/24.
//

import UIKit

class PopupVC: UIViewController {
    
    let popupMessage =  PopupMessageVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "PopUP"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController?.presentPanModal(popupMessage)
        }
       
    }

}
