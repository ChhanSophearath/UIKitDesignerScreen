//
//  PasscodeView.swift
//  PrimeCard_UserApp
//
//  Created by Sun Mengly on 2/1/24.
//

import UIKit

class PasscodeView: UIView , UITextFieldDelegate{
//    var isPassCodeType : isPassCodeType = .IS_LOGIN{
//        didSet{
//            if isPassCodeType == .IS_LOGIN{
//                
//                txtFeild.textColor = .orange
//            }else{
//        
//                txtFeild.textColor = .white
//            }
//        }
//    }
    
    let passView = UIView()
    let txtFeild = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabelView()
        setUpContrains()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        passView.layer.cornerRadius = passView.frame.width/2
    }
    
    func setUpLabelView() {
    
        addSubview(passView)
        passView.translatesAutoresizingMaskIntoConstraints = false
        passView.backgroundColor = .white.withAlphaComponent(0.5)
//        passView.layer.borderColor = UIColor.orange.cgColor
//        passView.layer.borderWidth = 1
        
        
        addSubview(txtFeild)
        txtFeild.translatesAutoresizingMaskIntoConstraints = false
        txtFeild.textColor = .orange
        txtFeild.text = ""
        txtFeild.delegate = self
        txtFeild.placeholder = ""
        txtFeild.isSecureTextEntry = true

        txtFeild.font = .systemFont(ofSize: 38, weight: .bold)
        
    }
    
    func setUpContrains() {
        
        NSLayoutConstraint.activate([
            passView.topAnchor.constraint(equalTo: topAnchor),
            passView.leftAnchor.constraint(equalTo: leftAnchor),
            passView.rightAnchor.constraint(equalTo: rightAnchor),
            passView.bottomAnchor.constraint(equalTo: bottomAnchor),

            
            txtFeild.topAnchor.constraint(equalTo: topAnchor),
            txtFeild.leftAnchor.constraint(equalTo: leftAnchor,constant: -4),
            txtFeild.rightAnchor.constraint(equalTo: rightAnchor),
            txtFeild.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtFeild.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(range.location)
       
        return range.location == 0
    }
    

}

class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}



import Foundation
import UIKit
import LocalAuthentication

class FingerPrintAndFaceID {
  static var shared = FingerPrintAndFaceID()
  var context:LAContext?
  
  enum DataFingerIDFaceIdResult {
      case success(status: Bool)
      case failure(String)
      case no(Int)
  }
 
    func fingerPrintFaceID(_ status :@escaping (DataFingerIDFaceIdResult) -> Void){
        
        var error: NSError?
        context = LAContext()
        context?.localizedFallbackTitle = "Please use your Passcode"
        if ((context?.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) != nil) {
            if context!.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context?.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Access requires authentication") { success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            // self.context = nil
                            status(.success(status: success))
                            return
                        }else{
                            
                            guard let error = authenticationError else {  return }
                            self.context = nil
                            status(.failure(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code)))
                            
                        }
                    }
                }
            } else {
                status(.no(error!.code))
            }
        }else{
            status(.no(error!.code))
            
            guard let _ = error else {
                return
            }
        }
    }
  
  func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
      var message = ""
      if #available(iOS 11.0, macOS 10.13, *) {
          switch errorCode {
              case LAError.biometryNotAvailable.rawValue:
                  message = "Authentication could not start because the device does not support biometric authentication."
              
              case LAError.biometryLockout.rawValue:
                  message = "Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times."
              
              case LAError.biometryNotEnrolled.rawValue:
                  message = "Authentication could not start because the user has not enrolled in biometric authentication."
              
              default:
                  message = "Did not find error code on LAError object"
          }
      } else {
          switch errorCode {
              case LAError.touchIDLockout.rawValue:
                  message = "Too many failed attempts."
              
              case LAError.touchIDNotAvailable.rawValue:
                  message = "TouchID is not available on the device"
              
              case LAError.touchIDNotEnrolled.rawValue:
                  message = "TouchID is not enrolled on the device"
              
              default:
                  message = "Did not find error code on LAError object"
          }
      }
      
      return message
  }
  
  func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
      
      var message = ""
      
      switch errorCode {
          
      case LAError.authenticationFailed.rawValue:
          message = "The user failed to provide valid credentials"
          
      case LAError.appCancel.rawValue:
          message = "Authentication was cancelled by application"
          
      case LAError.invalidContext.rawValue:
          message = "The context is invalid"
          
      case LAError.notInteractive.rawValue:
          message = "Not interactive"
          
      case LAError.passcodeNotSet.rawValue:
          message = "Passcode is not set on the device"
          
      case LAError.systemCancel.rawValue:
          message = "Authentication was cancelled by the system"
          
      case LAError.userCancel.rawValue:
          message = "The user did cancel"
          
      case LAError.userFallback.rawValue:
          message = "The user chose to use the fallback(Enter Password)"

      default:
          message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
      }
      
      return message
  }

}
