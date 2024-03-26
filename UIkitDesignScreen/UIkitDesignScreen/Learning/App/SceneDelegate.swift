//
//  SceneDelegate.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 30/1/24.
//

import UIKit




class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        /// 1. Capture the scene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        /// 2. Create a new UIWindow using the windowScene constructor which takes in a window scene.
         window = UIWindow(windowScene: windowScene)
        
        /// 3. Create a view hierarchy programmatically
        let viewController = ListViewController()
//        viewController.view.backgroundColor = .white
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        /// 4. Set the root view controller of the window with your view controller
        window?.rootViewController = navigation
        
        /// 5. Set the window and call makeKeyAndVisible()
        window?.makeKeyAndVisible()
    }

    
    //MARK: working on background
    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect")
//        scheduleLocalNotification()
        

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("sceneDidEnterBackground")
       
    }

}


