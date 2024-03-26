//
//  NotificationVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 2/2/24.
//

import UIKit

//MARK: Push notification local -->:  1 - Configure in appDelegate

class NotificationVC: UIViewController {

    let buttonPush = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Push Notification"
        view.backgroundColor = .white
        setupUIView()
        setupContainer()
    }
    
    
    private func setupUIView(){
        buttonPush.layer.cornerRadius = 10
        buttonPush.backgroundColor = .orange
        buttonPush.setTitle("UIkitDesignScreen Push", for: .normal)
        buttonPush.addTarget(self, action: #selector(didTappedButtonPush), for: .touchUpInside)
    }
    
    private func setupContainer(){
        buttonPush.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonPush)
        NSLayoutConstraint.activate([
            buttonPush.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonPush.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            buttonPush.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            buttonPush.heightAnchor.constraint(equalToConstant: 50),
//            buttonPush.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    @objc private func didTappedButtonPush(){
        print("didTappedButtonPush")
        self.scheduleLocalNotification(body: "UIkitDesignScreen")
    }
    
    func scheduleLocalNotification(body: String = "") {
        let content = UNMutableNotificationContent()
        content.title = "ទទួលប្រាក់ពី XXX XXX"
        content.body = "500.00$ ទទួលបានក្នុងគណនី XXX XXX XXX"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) // 60 seconds for UIkitDesignScreen
        
        let request = UNNotificationRequest(identifier: "scheduledNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification background scheduled successfully.")
            }
        }
        
    }
}
