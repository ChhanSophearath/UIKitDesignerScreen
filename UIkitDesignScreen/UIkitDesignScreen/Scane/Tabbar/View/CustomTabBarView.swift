//
//  CustomTabBarView.swift
//  PrimeCard_UserApp
//
//  Created by Sun Mengly on 24/12/23.
//

import UIKit

class CustomTabBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private let itemListTitle: [String] = ["Home", "Location", "Reward", "Account"]
    private let itemListICone: [String] = ["bar_home", "bar_location", "bar_reward", "bar_account"]

    
    
    var indexTabbar = 0
    var didSelectedRow: ((_ index: Int)->())?
    var didTappedScan: (()->())?
    
    
    lazy var buttonCircle: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .gray
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(didTapScan), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CustomTabBarCell.self, forCellWithReuseIdentifier: CustomTabBarCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private var shapeLayer: CALayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        //           shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        //The below 4 lines are for shadow above the bar. you can skip them if you do not want a shadow
        shapeLayer.shadowOffset = CGSize(width:0, height:5)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.8
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapScan(){
        self.didTappedScan?()
    }
    
    private func setupUIView(){
        addSubview(collectionView)
        addSubview(buttonCircle)
        
        buttonCircle.layer.cornerRadius = 32.5
        buttonCircle.layer.shadowOffset = CGSize(width: 0, height: 10)
        buttonCircle.layer.shadowColor = UIColor.red.cgColor
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor,constant: -120),
            
            buttonCircle.widthAnchor.constraint(equalToConstant: 65),
            buttonCircle.heightAnchor.constraint(equalToConstant: 65),
         
            buttonCircle.rightAnchor.constraint(equalTo: rightAnchor,constant: -39),
            buttonCircle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
        ])
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    //MARK : Draw view corner
    private func createPath() -> CGPath {
        let height: CGFloat = 55
        let heightTwo: CGFloat = height - 47
        
        let topZise: CGFloat = 45
        let bottomSize: CGFloat = 47
        let cornerTop = 8.0
        
        let path = UIBezierPath()
        let centerWidth = self.frame.width  - 70
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - heightTwo * cornerTop), y: 0)) // the beginning of the trough
        
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - topZise), y: 0), controlPoint2: CGPoint(x: centerWidth - bottomSize, y: height))
        
        path.addCurve(to: CGPoint(x: (centerWidth + heightTwo * cornerTop), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + bottomSize, y: height), controlPoint2: CGPoint(x: (centerWidth + topZise), y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
}



extension CustomTabBarView{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemListICone.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabBarCell.identifier, for: indexPath) as! CustomTabBarCell
        
        cell.imgIConTabBar.image = UIImage(named: itemListICone[indexPath.row])
        cell.lblTitleTabBar.textColor = .orange
        cell.imgIConTabBar.setImageColor(color: .orange)
        cell.lblTitleTabBar.text = itemListTitle[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  =  (collectionView.frame.width-30)/4
        return CGSize(width: width , height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                let select  = IndexPath(item: indexTabbar, section: 0)
                collectionView.selectItem(at: select, animated: false, scrollPosition: .centeredVertically)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectedRow?(indexPath.row)
    }
}

