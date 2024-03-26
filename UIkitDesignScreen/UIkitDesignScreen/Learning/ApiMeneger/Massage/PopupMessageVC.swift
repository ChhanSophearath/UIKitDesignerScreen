//
//  PopupMessageVC.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 2/2/24.
//

import UIKit
import PanModal


class PopupMessageVC: UIViewController {

    var didTappedDelete : (()->())?

    lazy var viewPresent: UIView = {
        let viewPresent = UIView()
        viewPresent.translatesAutoresizingMaskIntoConstraints = false
        viewPresent.backgroundColor = .clear
        viewPresent.layer.cornerRadius =  20
        return viewPresent
    }()
    
    lazy var viewPresentScroll: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var btnBig: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(self.didTapButton(_:)), for: .touchUpInside)
        btn.setTitle("dismiss", for: .normal)
        return btn
    }()
    
    
    lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Massage!!!"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var lblSubTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Please click the button below to confirm the deletion of data."
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()

    lazy var imgLogo: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon_wifi")
        img.contentMode = .scaleAspectFill
        img.alpha = 0.2
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
    }

    private func setupView(){
        view.addSubview(viewPresentScroll)
        viewPresentScroll.addSubview(viewPresent)
        viewPresent.addSubview(imgLogo)
        viewPresent.addSubview(btnBig)
        viewPresent.addSubview(lblTitle)
        viewPresent.addSubview(lblSubTitle)

        NSLayoutConstraint.activate([
 
            viewPresentScroll.topAnchor.constraint(equalTo: view.topAnchor),
            viewPresentScroll.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewPresentScroll.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewPresentScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewPresentScroll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            viewPresent.leftAnchor.constraint(equalTo: viewPresentScroll.leftAnchor),
            viewPresent.rightAnchor.constraint(equalTo: viewPresentScroll.rightAnchor),
            viewPresent.bottomAnchor.constraint(equalTo: viewPresentScroll.bottomAnchor),
            viewPresent.topAnchor.constraint(equalTo: viewPresentScroll.topAnchor),
            viewPresent.centerXAnchor.constraint(equalTo: viewPresentScroll.centerXAnchor),
            viewPresent.heightAnchor.constraint(equalToConstant: 190),
            //---
            btnBig.bottomAnchor.constraint(equalTo: viewPresent.bottomAnchor ,constant: -10),
            btnBig.rightAnchor.constraint(equalTo: viewPresent.rightAnchor,constant: .mainRight),
            btnBig.leftAnchor.constraint(equalTo: viewPresent.leftAnchor,constant: .mainLeft),
            btnBig.heightAnchor.constraint(equalToConstant: 45),
            //--
            lblTitle.topAnchor.constraint(equalTo: viewPresent.topAnchor, constant: 50),
            lblTitle.leadingAnchor.constraint(equalTo: viewPresent.leadingAnchor, constant: .mainLeft),
            lblTitle.trailingAnchor.constraint(equalTo: viewPresent.trailingAnchor, constant: .mainRight),
            //--
            lblSubTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10),
            lblSubTitle.leadingAnchor.constraint(equalTo: viewPresent.leadingAnchor, constant: .mainLeft),
            lblSubTitle.trailingAnchor.constraint(equalTo: viewPresent.trailingAnchor, constant: .mainRight),

        ])
    }
    
    @objc  private func didTapButton(_ sender : UIButton){
        self.dismiss(animated: true)
        self.didTappedDelete?()
    }
}

extension PopupMessageVC: PanModalPresentable {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    var panScrollable: UIScrollView? {
        return self.viewPresentScroll
    }

    var anchorModalToLongForm: Bool {
        return false
    }
}
