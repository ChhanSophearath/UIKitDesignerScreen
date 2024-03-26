//
//  CustomTabBarCell.swift
//  PrimeCard_UserApp
//
//  Created by Rath! on 21/12/23.
//

import UIKit

class CustomTabBarCell: UICollectionViewCell {
    
  static let identifier = "CustomTabBarCell"
    
    lazy var imgIConTabBar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.setImageColor(color: .orange)
        imageView.tintColor = .orange
        return imageView
    }()
    
    lazy var lblTitleTabBar: UILabel = {
        let lb = UILabel()
        lb.textColor = .orange
        lb.text = "_"
//        lb.fontRegular(11)
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override var isSelected: Bool{
        didSet{
            
            if isSelected {
                imgIConTabBar.setImageColor(color: .red)
                lblTitleTabBar.textColor = .red

                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.backgroundColor = .lightGray.withAlphaComponent(0.1)
                }, completion: { _ in
                    self.backgroundColor = .clear
                })
                
                
          
                
            }else{
                imgIConTabBar.setImageColor(color: .orange)
                lblTitleTabBar.textColor = .orange

            }
              
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func setupConstraint() {
        addSubview(lblTitleTabBar)
        addSubview(imgIConTabBar)
       
        NSLayoutConstraint.activate([
            imgIConTabBar.topAnchor.constraint(equalTo: topAnchor,constant:  12),
            imgIConTabBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgIConTabBar.heightAnchor.constraint(equalToConstant: 20),
            imgIConTabBar.widthAnchor.constraint(equalToConstant: 20),
            
            lblTitleTabBar.topAnchor.constraint(equalTo: imgIConTabBar.bottomAnchor,constant: 10),
            lblTitleTabBar.rightAnchor.constraint(equalTo: rightAnchor),
            lblTitleTabBar.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
}

