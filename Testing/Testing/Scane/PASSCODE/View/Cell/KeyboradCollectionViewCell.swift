//
//  KeyboradCollectionViewCell.swift
//  PrimeCard_UserApp
//
//  Created by Sun Mengly on 2/1/24.
//

import UIKit


class KeyboradCollectionViewCell: UICollectionViewCell {
    var isPassCodeType : isPassCodeType = .IS_LOGIN {
        didSet{
            
            if isPassCodeType == .IS_LOGIN{
                // Set the original background color
                button.setBackgroundImage(imageWithColor(color: UIColor.orange), for: .normal)
                // Set the highlighted background color
                button.setBackgroundImage(imageWithColor(color: UIColor.orange.withAlphaComponent(0.20)), for: .highlighted)
            }else{
                // Set the original background color
                button.setBackgroundImage(imageWithColor(color: UIColor.white.withAlphaComponent(0.25)), for: .normal)
                // Set the highlighted background color
                button.setBackgroundImage(imageWithColor(color: UIColor.white.withAlphaComponent(0.90)), for: .highlighted)
            }
        }
    }
    static let cellID = "KeyboradCellID"
    let button = UIButton()

    var data: KeyboradModel! {
        didSet {
            if data.label == " "{
                button.isHidden = true
            }else{
                if data.label == "" {

                    button.isHidden = false
                    button.setImage(UIImage(named: data.icon), for: .normal)
                    button.setTitle("", for: .normal)
                    
                }else {
                    button.isHidden = false
                    button.setTitle(data.label, for: .normal)
                    button.setImage(nil, for: .normal)
                }
            }
   
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.layer.cornerRadius = 23
        self.layer.masksToBounds = true
        setUpKeyborad()
        setUpContrains()
    }
    
    func setUpKeyborad() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFit
        //MARK: Set color when select
        button.setBackgroundImage(imageWithColor(color: UIColor.orange.withAlphaComponent(0.10)), for: .highlighted)
    }
    

    

    
    func setUpContrains() {
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),

        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

