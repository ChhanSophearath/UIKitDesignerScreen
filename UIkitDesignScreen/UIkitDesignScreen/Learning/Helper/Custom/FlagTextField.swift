//
//  FlagTextField.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 3/2/24.
//

import Foundation
import UIKit


class FlagTextField: UIView {
    
    var strPrefix: String = ""
    var textDidChange: ((_ text :String)->())?
    var isComplete: ((_ booltype: Bool)->())?
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .none// .roundedRect
        textField.placeholder = "123 456 789"
        textField.keyboardType = .numberPad
        textField.tintColor = .red
        textField.delegate = self
        return textField
    }()
    
    lazy var lblBarCode: UILabel = {
        let lbl = UILabel()
        lbl.text = "855"
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var imgDropdonw: UIImageView = {
        let  img = UIImageView()
        img.contentMode = .scaleAspectFit
//        img.image = UIImage.icDrop
        img.isHidden = true
        return img
    }()
    
    lazy var imgCorrect: UIImageView = {
        let  img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "ic_circle")
        img.isHidden = true
        return img
    }()
    
    lazy var imgFlag: UIImageView = {
        let  img = UIImageView()
        img.contentMode = .scaleToFill
//        img.image = UIImage.imgKhmer
        return img
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        textField.fontRegular(17)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
        setupUI()
    }
    
    func setupUI(){
        
        let allView: [UIView] = [imgFlag,
                                 lblBarCode,
                                 imgDropdonw,
                                 lineView,
                                 textField,
                                 imgCorrect
        ]
        
        allView.forEach({ value in
            value.translatesAutoresizingMaskIntoConstraints = false
            addSubview(value)
            value.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
        })
        
        NSLayoutConstraint.activate([
            imgFlag.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
            imgFlag.heightAnchor.constraint(equalToConstant: 20),
            imgFlag.widthAnchor.constraint(equalToConstant: 29),
            
            lblBarCode.leftAnchor.constraint(equalTo: imgFlag.rightAnchor, constant: 7),
            lblBarCode.widthAnchor.constraint(equalToConstant: 38),
            
            imgDropdonw.leftAnchor.constraint(equalTo: lblBarCode.rightAnchor, constant: 0),
            imgDropdonw.widthAnchor.constraint(equalToConstant: 12),
            imgDropdonw.heightAnchor.constraint(equalToConstant: 12),
            
            lineView.heightAnchor.constraint(equalToConstant: 26),
            lineView.widthAnchor.constraint(equalToConstant: 1),
            lineView.leftAnchor.constraint(equalTo: imgDropdonw.rightAnchor, constant: 7),
            
            textField.leftAnchor.constraint(equalTo: lineView.rightAnchor, constant: 15),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            imgCorrect.rightAnchor.constraint(equalTo: textField.rightAnchor, constant: -10),
            imgCorrect.widthAnchor.constraint(equalToConstant: 18),
            imgCorrect.heightAnchor.constraint(equalToConstant: 18),
            imgCorrect.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            //--
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FlagTextField: UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else{
            return
        }
        
        
        textDidChange?( text)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(range)
        guard let text = self.textField.text else {return false}
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)

        let prefix6Digit = ["11", "12", "14", "17", "61", "76", "77", "78", "85", "89", "92", "95", "99","10", "15", "016", "69", "70", "81", "86", "87", "93","98","60", "66", "67", "68", "90","13", "80", "83", "84"]
//        let prefix7Digit = ["96","88", "97", "71", "31", "18","38"]
        
       
        
        if self.textField.text?.count ?? 0 < 2{
            if newString.first == "0"{
                let dropNewString = newString.dropFirst()
                
                self.textField.text = formatter(mask: "XX XXX XXX X", phoneNumber: String(dropNewString))
                
            }else {
                self.textField.text = formatter(mask: "XX XXX XXX X", phoneNumber: newString)
            }
        }else{
            if self.textField.text?.count == 2{
                strPrefix = self.textField.text ?? ""
            }

            if prefix6Digit.contains(strPrefix){
                if newString.first == "0"{
                    let dropNewString = newString.dropFirst()
                    self.textField.text = formatter(mask: "XX XX XX XX", phoneNumber: String(dropNewString))
                }else {
                    self.textField.text = formatter(mask: "XX XX XX XX", phoneNumber: newString)
                }
    
                if self.textField.text?.count == 11{
                    self.isComplete?(true)
                    self.imgCorrect.isHidden = false
                }else{
                    self.isComplete?(false)
                    self.imgCorrect.isHidden = true
                }
            }else{
                if newString.first == "0"{
                    let dropNewString = newString.dropFirst()
                    self.textField.text = formatter(mask: "XX XXX XXX X", phoneNumber: String(dropNewString))
                }else {
                    self.textField.text = formatter(mask: "XX XXX XXX X", phoneNumber: newString)
                }
                
                if self.textField.text?.count == 12{
                    self.isComplete?(true)
                    self.imgCorrect.isHidden = false
                }else{
                    self.isComplete?(false)
                    self.imgCorrect.isHidden = true
                }
   
            }
        }

    
        
        return false
        
    }
    
}



func formatter(mask: String, phoneNumber: String) -> String {
    let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result:String = ""
    var index = number.startIndex

    
    for character in mask where index < number.endIndex {
        if character == "X"{
            result.append(number[index])
            index = number.index(after: index)
        }else {
            result.append(character)
        }
    }
    return result
}

