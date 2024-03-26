//
//  Loading.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 30/1/24.
//

import Foundation
import UIKit
//import NVActivityIndicatorView

class Loading {
    static let shared = Loading()
    var isLoading: Bool = false
    let loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.color = .orange
        loading.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return loading
        
    }()
    

    func showLoading() {
        DispatchQueue.main.async { [self] in
            
            guard let window = UIApplication.shared.keyWindow else {
                print("Window is nil.")
                return
            }

//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                for window in windowScene.windows {
//                    if window.isKeyWindow {
//                        // Do something with the key window
//                        break
//                    }
//                }
//            }

            
          
            self.loadingView.translatesAutoresizingMaskIntoConstraints = false

            window.addSubview(self.loadingView)

            self.loadingView.widthAnchor.constraint(equalTo: window.widthAnchor).isActive = true
            self.loadingView.heightAnchor.constraint(equalTo: window.heightAnchor).isActive = true
            self.loadingView.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            self.loadingView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            

            
            self.loadingView.startAnimating()
            self.isLoading = true
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [self] in
            self.loadingView.stopAnimating()
            self.isLoading = false
        }
    }
}
