//
//  MenuListCell.swift
//  PrimeCard_UserApp
//
//  Created by Rath! on 23/2/24.
//

import Foundation
import UIKit

class MenuListCell: UICollectionViewCell {
    
    var nsWidth = NSLayoutConstraint()
    var nsHeight = NSLayoutConstraint()
    
    var sizeImage:CGFloat = 64{
        didSet{

            nsHeight.isActive = false
            nsWidth.isActive = false
            nsHeight = imgIcone.heightAnchor.constraint(equalToConstant: sizeImage)
            nsWidth =   imgIcone.widthAnchor.constraint(equalToConstant: sizeImage)
            nsHeight.isActive = true
            nsWidth.isActive = true
        }
    }
    
    
    let imgIcone: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .orange
        label.fontLight(14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        backgroundColor = .clear
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    private func setupViews() {
        // Add and configure subviews
        contentView.addSubview(imgIcone)
        contentView.addSubview(titleLabel)
        
        // Configure constraints
        imgIcone.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        nsHeight = imgIcone.heightAnchor.constraint(equalToConstant: sizeImage)
        nsWidth =   imgIcone.widthAnchor.constraint(equalToConstant: sizeImage)
        
        nsHeight.isActive = true
        nsWidth.isActive = true
        
        NSLayoutConstraint.activate([


            imgIcone.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgIcone.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -8),
            

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8)
        ])
    }
}
