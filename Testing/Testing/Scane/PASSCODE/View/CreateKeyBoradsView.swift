//
//  CreateKeyBoradsView.swift
//  PrimeCard_UserApp
//
//  Created by Sun Mengly on 2/1/24.
//

import UIKit

enum KeyboradType{
    case keyOne
    case keyTow
    case keyThree
    case keyFour
}



class CreateKeyBoradsView: UIView {
    
    var isPassCodeType : isPassCodeType = .IS_LOGIN {
        didSet{
            
        }
    }
    
    let containerView = UIView()
    var closerClickOnKeyBorads: ((KeyboradModel)->Void)?
    var checkValueTapped:((Int) -> ())?
    var collectionView: UICollectionView!
    var heightContainer: NSLayoutConstraint?
    
    var padding: CGFloat = 16
    
    var keyboradsData: [KeyboradModel] =  [
        KeyboradModel.init(label: "1", icon: ""),
        KeyboradModel.init(label: "2", icon: ""),
        KeyboradModel.init(label: "3", icon: ""),
        KeyboradModel.init(label: "4", icon: ""),
        KeyboradModel.init(label: "5", icon: ""),
        KeyboradModel.init(label: "6", icon: ""),
        KeyboradModel.init(label: "7", icon: ""),
        KeyboradModel.init(label: "8", icon: ""),
        KeyboradModel.init(label: "9", icon: ""),
        KeyboradModel.init(label: ".", icon: ""),
        KeyboradModel.init(label: "0", icon: ""),
        KeyboradModel.init(label: "", icon: "delete"),
    ]
    
    var checkKeyboardFigerprint:Int = 0{
        didSet{
            if self.checkKeyboardFigerprint == 0 {
                keyboradsData = [
                    KeyboradModel.init(label: "1", icon: ""),
                    KeyboradModel.init(label: "2", icon: ""),
                    KeyboradModel.init(label: "3", icon: ""),
                    KeyboradModel.init(label: "4", icon: ""),
                    KeyboradModel.init(label: "5", icon: ""),
                    KeyboradModel.init(label: "6", icon: ""),
                    KeyboradModel.init(label: "7", icon: ""),
                    KeyboradModel.init(label: "8", icon: ""),
                    KeyboradModel.init(label: "9", icon: ""),
                    KeyboradModel.init(label: " ", icon: ""),
                    KeyboradModel.init(label: "0", icon: ""),
                    KeyboradModel.init(label: "", icon: "delete"),
                ]
            }else if self.checkKeyboardFigerprint == 1 {
                keyboradsData = [
                    KeyboradModel.init(label: "1", icon: ""),
                    KeyboradModel.init(label: "2", icon: ""),
                    KeyboradModel.init(label: "3", icon: ""),
                    KeyboradModel.init(label: "4", icon: ""),
                    KeyboradModel.init(label: "5", icon: ""),
                    KeyboradModel.init(label: "6", icon: ""),
                    KeyboradModel.init(label: "7", icon: ""),
                    KeyboradModel.init(label: "8", icon: ""),
                    KeyboradModel.init(label: "9", icon: ""),
                    KeyboradModel.init(label: ".", icon: ""),
                    KeyboradModel.init(label: "0", icon: ""),
                    KeyboradModel.init(label: "", icon: "delete"),
                    
                    
                ]
            }else{
                let bio = UserDefaults.standard.string(forKey: AppConstants.GetBiometricsName )
                
                if bio == "TouchID" || bio == "Biometrics Unavailable"{
                    keyboradsData = [
                        KeyboradModel.init(label: "1", icon: ""),
                        KeyboradModel.init(label: "2", icon: ""),
                        KeyboradModel.init(label: "3", icon: ""),
                        KeyboradModel.init(label: "4", icon: ""),
                        KeyboradModel.init(label: "5", icon: ""),
                        KeyboradModel.init(label: "6", icon: ""),
                        KeyboradModel.init(label: "7", icon: ""),
                        KeyboradModel.init(label: "8", icon: ""),
                        KeyboradModel.init(label: "9", icon: ""),
                        KeyboradModel.init(label: "", icon: "fingerprint"),
                        KeyboradModel.init(label: "0", icon: ""),
                        KeyboradModel.init(label: "", icon: "delete"),
                    ]
                }else{
                    keyboradsData = [
                        KeyboradModel.init(label: "1", icon: ""),
                        KeyboradModel.init(label: "2", icon: ""),
                        KeyboradModel.init(label: "3", icon: ""),
                        KeyboradModel.init(label: "4", icon: ""),
                        KeyboradModel.init(label: "5", icon: ""),
                        KeyboradModel.init(label: "6", icon: ""),
                        KeyboradModel.init(label: "7", icon: ""),
                        KeyboradModel.init(label: "8", icon: ""),
                        KeyboradModel.init(label: "9", icon: ""),
                        KeyboradModel.init(label: "", icon: "faceID"),
                        KeyboradModel.init(label: "0", icon: ""),
                        KeyboradModel.init(label: "", icon: "delete"),
                    ]
                }

            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()

            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCreateKey()
        setUpContrains()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.reloadData()
        }
    }
    
    func setUpCreateKey() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .cyan
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeyboradCollectionViewCell.self, forCellWithReuseIdentifier: KeyboradCollectionViewCell.cellID)
        containerView.addSubview(collectionView)
    }
    
    func setUpContrains() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -44)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: padding),
            collectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: padding),
            collectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -padding)
        ])
        heightContainer = collectionView.heightAnchor.constraint(equalToConstant: 1)
        heightContainer?.isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heightContainer?.constant =  collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CreateKeyBoradsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboradsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboradCollectionViewCell.cellID, for: indexPath) as! KeyboradCollectionViewCell
        cell.data = keyboradsData[indexPath.row]
        cell.isPassCodeType = self.isPassCodeType
        print("index \(indexPath.row)")
        //MARK: FingerPrint
        if checkKeyboardFigerprint == 0 {
            if cell.data.icon == "fingerprint" {
                cell.data.label = ""
                cell.data.icon = "fingerprint"
            }
            //MARK: .
        } else if checkKeyboardFigerprint == 1 {
            if cell.data.icon == "fingerprint" {
                cell.data.label = "."
                cell.data.icon = ""
            }
            //MARK: FaceID
        } else if checkKeyboardFigerprint == 2 {
            
            if cell.data.icon == "faceID" {
                cell.data.label = ""
                cell.data.icon = "face-id"
            }
        }
        cell.button.tag = indexPath.row
        
        cell.button.addTarget(self, action: #selector(self.didTapButton(_:)), for: .touchUpInside)
//        if indexPath.row == 9{
//            if cell.data.icon == "faceID" || cell.data.icon == "fingerprint"{
//                cell.backgroundColor = .orange
//            }else{
//                cell.backgroundColor  = .orange
//            }
//        }

        return cell
    }
    
    @objc func didTapButton(_ sender : UIButton){
        let  data = keyboradsData[sender.tag]
        closerClickOnKeyBorads?(data)
        let generator = UIImpactFeedbackGenerator(style: .light) // You can change the style to .medium or .heavy
        generator.prepare()
        generator.impactOccurred()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var constant: CGFloat = 50



        return .init(width: (collectionView.frame.width / 3) - 9, height: constant) //60
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.collectionView.deselectItem(at: indexPath, animated: true)
//        let  data = keyboradsData[indexPath.row]
//        if data.label != "" || data.label != " " {
//            // Vibrate
//            UIDevice.vibrate()
//            print("Vibrate")
//        }
        
//        closerClickOnKeyBorads?(data)

    }
 
}

struct KeyboradModel {
    var label: String
    var icon: String
}

