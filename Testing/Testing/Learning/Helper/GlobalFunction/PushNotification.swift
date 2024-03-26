//
//  FunctionPushNotification.swift
//  IQ
//
//  Created by Rath! on 3/2/24.
//

import Foundation
import UserNotifications


func scheduleLocalNotification(body: String = "") {
    let content = UNMutableNotificationContent()
    content.title = "My Notification Background"
    content.body = "This is a scheduled push notification \(body)"
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true) // 60 seconds for testing
    
    let request = UNNotificationRequest(identifier: "scheduledNotification", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Notification background scheduled successfully.")
        }
    }
}
