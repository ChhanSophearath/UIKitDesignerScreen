//
//  ButtonOnKeyboradVC.swift
//  IQ
//
//  Created by Rath! on 9/2/24.
//

import UIKit

class ButtonOnKeyboradVC: UIViewController {

   private var nsContrainButton =  NSLayoutConstraint()
   private let  textField = UITextField()
    
   private let button = UIButton()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Button On Keyborad"
        view.backgroundColor = .white
        setupUIView()
        setupButtonOnKeyborad()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    private func setupButtonOnKeyborad(){
        view.registerForKeyboardNotifications()
        
        view.keyboardWillShownClosure = { [self] height in
            nsContrainButton.isActive  = false
            nsContrainButton =   button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: height)
            nsContrainButton.isActive  = true
        }
        
        view.keyboardWillBeHiddenClosure = { [self] in
            nsContrainButton.isActive  = false
            nsContrainButton =   button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            nsContrainButton.isActive  = true
        }
    }
    

    private func setupUIView(){
        button.setTitle("Button on Keyborad", for: .normal)
        view.addSubview(button)
        view.addSubview(textField)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .orange
        textField.backgroundColor = .lightGray
        textField.placeholder = "Enter your text...."
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.addDoneButtonOnKeyboard()
        textField.textContentType = .oneTimeCode
//        textField.
        
        NSLayoutConstraint.activate([

            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
    
        ])
        nsContrainButton =   button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        nsContrainButton.isActive  = true
    }

  
}
