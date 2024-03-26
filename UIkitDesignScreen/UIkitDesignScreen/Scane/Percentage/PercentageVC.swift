//
//  PercentageVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 9/2/24.
//

import UIKit

class PercentageVC: UIViewController {
    
    private var timer: Timer!
    private var progress: Float = 0.0
    var max:Float = 150
    var mamValue:Float = 50
    var getPercentage: Float =  (50/150) * 100
    
    var iconImageView = UIView()
    
    private var changeAnimate = NSLayoutConstraint()
    
    private let percentage = UIProgressView(progressViewStyle: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPercentage()
        startProgressAnimation()
    }
    
    
    func startProgressAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    private func setupPercentage(){
        percentage.translatesAutoresizingMaskIntoConstraints = false
        percentage.backgroundColor = .orange
        percentage.progress = 0.0
        percentage.layer.cornerRadius = 15
        percentage.clipsToBounds = true
        
        
        view.addSubview(percentage)
        percentage.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            percentage.heightAnchor.constraint(equalToConstant: 30),
            percentage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            percentage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            percentage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: percentage.centerYAnchor),
        ])
       
        changeAnimate =  iconImageView.rightAnchor.constraint(equalTo: view.leftAnchor,constant: 0)
        changeAnimate.isActive = true
        
    }
    
    
    @objc func updateProgress() {
        
        if getPercentage > 0{
            
            progress += getPercentage/100 //MARK: Need change getPercentage
            updateIconPosition(progress: progress)
            percentage.setProgress(progress, animated: true)
            
            // Check if progress reaches 100%
            if progress >= getPercentage/100 {  //MARK: Need change getPercentage
                timer?.invalidate() // Stop the timer
                print("Progress complete!")
            }
        }
    }
    
    func updateIconPosition(progress: Float?) {
        if progress == 0{

            iconImageView.isHidden = true
        }else{
            
            if progress ?? 0 >= 1{
                iconImageView.isHidden = true
            }else{
                iconImageView.isHidden = false
            }
           
            let progressWidth = percentage.frame.width * CGFloat(progress ?? 0)
            let iconX = percentage.frame.origin.x + progressWidth - 7  //(iconImageView.frame.width / 2)
            
            
            changeAnimate.isActive = false
            changeAnimate = iconImageView.leftAnchor.constraint(equalTo: percentage.leftAnchor,constant: progressWidth  )
            changeAnimate.isActive = true
            
        }
        UIView.animate(withDuration: TimeInterval(progress ?? 0)) {
            self.view.layoutIfNeeded()
        }
        
    }
    

}
