//
//  AlertMassage.swift
//  IQ
//
//  Created by Rath! on 30/1/24.
//

import Foundation
import UIKit
import PanModal

extension CGFloat{
    static let mainRight: CGFloat = -16
    static let  mainLeft: CGFloat = 16
}


class AlertMessage {
    //MARK: singleton parturn
    static let shared = AlertMessage()

    func showSuccess(message: String) {
        DispatchQueue.main.async {
            let popupViewController = PopupMessageVC()
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController?.presentPanModal(popupViewController)
            }
        }
    }
    
    func showAlert(message: String) {
        
        DispatchQueue.main.async {
            
            let popupViewController = PopupMessageVC()
            popupViewController.lblTitle.text = "Message!!!"
            popupViewController.lblSubTitle.text = message
            popupViewController.btnBig.setTitle("OK", for: .normal)
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController?.presentPanModal(popupViewController)
            }
        }
        
    }
}

