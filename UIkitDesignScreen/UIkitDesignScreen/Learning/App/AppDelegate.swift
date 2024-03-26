//
//  AppDelegate.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 30/1/24.
//

import UIKit
import UserNotifications //MARK: For push notification 1

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        configureNotification()  // push notification 2
        
        print("didFinishLaunchingWithOptions")
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("configurationForConnecting")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
        print("didDiscardSceneSessions")
    }
}




//MARK: For push notification
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    
    private func configureNotification(){
        // Request user authorization for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            granted ? print("User granted authorization") :  print("User denied authorization")
        }
        // Set the delegate for UNUserNotificationCenter
        UNUserNotificationCenter.current().delegate = self
    }
    
    
    // Handle the display of notifications while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Customize the presentation options as needed
        completionHandler([.alert, .sound])
    }
    
    // Handle the user's response to the notification (e.g., tapping on it) tapped on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the response as needed
        // Handle the notification response here
        let userInfo = response.notification.request.content.userInfo
        
        print("userInfo: \(userInfo)")
        
        // Extract any relevant information from the notification
        
        // Perform custom actions based on the notification
        
        // Get the current view controller
//        guard let window = UIApplication.shared.keyWindow,
//              let rootViewController = window.rootViewController else {
//            completionHandler()
//            return
//        }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            completionHandler()
            return
        }
        
        
        
        // Create an instance of the target view controller
        let targetViewController = UIkitDesignScreenVC1()
        
        // Push the target view controller onto the navigation stack
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.pushViewController(targetViewController, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: targetViewController)
            window.rootViewController = navigationController
        }
        
        // Call the completion handler when you're done processing the notification
        completionHandler()
        
    }
}
