//
//  PassCodeViewController.swift
//  PrimeCard_UserApp
//
//  Created by Sun Mengly on 2/1/24.
//

import UIKit
import LocalAuthentication

enum isPassCodeType {
    case IS_LOGIN
    case IS_PAYMENT
    case IS_CONFIRM
    case IS_TRANSFER_POINT
    case IS_TRANSFER_VOUCHER
    case IS_PAYMENT_CASH
    case IS_PAYMENT_POINT
    case IS_CLAIM_MERCHANDISE
    case IS_CONFIRM_DONATE
}

var isOpenedOtherApp : Bool = false


class PassCodeVC: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    var vouchers : [Int] = []
    var point : Int = 0
    var number : String = ""
    var ref : String = ""
    var amount : Double = 0.0
    var type : String = ""
    
    lazy var imgProfile : UIImageView = {
        let img  = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isHidden = true
        img.layer.cornerRadius = 34
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    
    var didTappedForgotPassword : (()->())?
    
    
    
    
    let imgViewBG  = UIImageView()
    
    lazy var  imgViewBGBehine  : UIImageView = {
        let img  = UIImageView()
        img.isHidden = true
        return img
    }()
    
    var strPhoneNumber : String = ""
    let inputLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter your PIN."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.fontRegular(14)
        return label
    }()
    
    lazy var ForgotPasswordButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Forget PIN code", for: .normal)
        btn.titleLabel?.textAlignment = .right
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(didTapForgotPassword(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    private var getPasscodeOne:[String] = []
    lazy var stackViewTextField = UIStackView(arrangedSubviews: [label1, label2, label3, label4, label5, label6])
    private let label1 = PasscodeView()
    private let label2 = PasscodeView()
    private let label3 = PasscodeView()
    private let label4 = PasscodeView()
    private let label5 = PasscodeView()
    private let label6 = PasscodeView()
    
    let KeyBoradView = CreateKeyBoradsView()
    
    var blurEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setUpKeybords()
        setupView()
        KeyBoradView.backgroundColor = .lightGray
        
        
        self.navigationItem.title =  "Confirm PIN"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleBackFromABAapp), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
        KeyBoradView.closerClickOnKeyBorads = { [self] dateText in
            
            if dateText.icon == "fingerprint" || dateText.icon == "faceID" {
                FingerPrintAndFaceID.shared.fingerPrintFaceID({ (check) in
                    switch check {
                    case .success(_):
                        
                        break
                    case .failure( _):
                        
                        break
                    case .no:
                        
                        break
                    }
                })
            }
            
            if dateText.icon == "delete" {
                
                if label6.txtFeild.text != "" {
                    getPasscodeOne.removeLast()
                    label6.txtFeild.text = ""
                    
                    label6.passView.layer.borderWidth = 0
                    label6.passView.layer.borderColor = UIColor.clear.cgColor
                    
                    label5.passView.layer.borderWidth = 0
                    label5.passView.layer.borderColor = UIColor.white.cgColor
                    
                }
                
                else if label5.txtFeild.text != "" {
                    getPasscodeOne.removeLast()
                    label5.txtFeild.text = ""
                    
                    label5.passView.layer.borderWidth = 0
                    label5.passView.layer.borderColor = UIColor.clear.cgColor
                    
                    label4.passView.layer.borderWidth = 0
                    label4.passView.layer.borderColor = UIColor.white.cgColor
                    
                }
                else if label4.txtFeild.text != "" {
                    getPasscodeOne.removeLast()
                    label4.txtFeild.text = ""
                    
                    label4.passView.layer.borderWidth = 0
                    label4.passView.layer.borderColor = UIColor.clear.cgColor
                    
                    label3.passView.layer.borderWidth = 0
                    label3.passView.layer.borderColor = UIColor.white.cgColor
                    
                }
                else if label3.txtFeild.text != "" {
                    getPasscodeOne.removeLast()
                    label3.txtFeild.text = ""
                    
                    label3.passView.layer.borderWidth = 0
                    label3.passView.layer.borderColor = UIColor.clear.cgColor
                    
                    label2.passView.layer.borderWidth = 0
                    label2.passView.layer.borderColor = UIColor.white.cgColor
                    
                }
                
                else if label2.txtFeild.text != "" {
                    getPasscodeOne.removeLast()
                    label2.txtFeild.text = ""
                    
                    label2.passView.layer.borderWidth = 0
                    label2.passView.layer.borderColor = UIColor.clear.cgColor
                    
                    label1.passView.layer.borderWidth = 0
                    label1.passView.layer.borderColor = UIColor.white.cgColor
                }
                else if label1.txtFeild.text != "" {
                    getPasscodeOne.removeLast()
                    label1.txtFeild.text = ""
                    
                    label1.passView.layer.borderWidth = 0
                    label1.passView.layer.borderColor = UIColor.clear.cgColor
                    
                    
                }
                print("remove",getPasscodeOne)
                
                return
            }
            
            if label1.txtFeild.text == "" {
                label1.passView.layer.borderWidth = 0
                label1.passView.layer.borderColor = UIColor.white.cgColor
                label1.txtFeild.text = dateText.label
                getPasscodeOne.append(dateText.label)
                
            }
            else if label2.txtFeild.text == "" {
                label2.txtFeild.text = dateText.label
                getPasscodeOne.append(dateText.label)
                
                label1.passView.layer.borderWidth = 0
                label1.passView.layer.borderColor = UIColor.clear.cgColor
                
                label2.passView.layer.borderWidth = 0
                label2.passView.layer.borderColor = UIColor.white.cgColor
                
            }
            else if label3.txtFeild.text == "" {
                label3.txtFeild.text = dateText.label
                getPasscodeOne.append(dateText.label)
                
                label2.passView.layer.borderWidth = 0
                label2.passView.layer.borderColor = UIColor.clear.cgColor
                
                label3.passView.layer.borderWidth = 0
                label3.passView.layer.borderColor = UIColor.white.cgColor
            }
            else if label4.txtFeild.text == "" {
                label4.txtFeild.text = dateText.label
                getPasscodeOne.append(dateText.label)
                
                label3.passView.layer.borderWidth = 0
                label3.passView.layer.borderColor = UIColor.clear.cgColor
                
                label4.passView.layer.borderWidth = 0
                label4.passView.layer.borderColor = UIColor.white.cgColor
            }
            else if label5.txtFeild.text == "" {
                label5.txtFeild.text = dateText.label
                getPasscodeOne.append(dateText.label)
                
                label4.passView.layer.borderWidth = 0
                label4.passView.layer.borderColor = UIColor.clear.cgColor
                
                label5.passView.layer.borderWidth = 0
                label5.passView.layer.borderColor = UIColor.white.cgColor
                
            }
            else if label6.txtFeild.text == "" {
                label6.txtFeild.text = dateText.label
                getPasscodeOne.append(dateText.label)
                
                label5.passView.layer.borderWidth = 0
                label5.passView.layer.borderColor = UIColor.clear.cgColor
                
                label6.passView.layer.borderWidth = 0
                label6.passView.layer.borderColor = UIColor.clear.cgColor
                
                
                //MARK: Go to new screen
                
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .clear
        
        //Enable swapped navigation
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
        
        let leftBarItem = UIBarButtonItem(image: UIImage.barHome.withRenderingMode(.alwaysOriginal).withTintColor(.white), style: .done, target: self, action: #selector(backBtn))
        self.navigationItem.leftBarButtonItem = leftBarItem
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white // Set the color you want
        ]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black // Set the color you want
        ]
    }
    
    @objc func handleBackFromABAapp() {
        
        if isOpenedOtherApp{
            
            isOpenedOtherApp = false
            self.checkBackTranscation(payBy: "ABA_PAY")
        }
    }
    
    func checkBackTranscation(payBy:String){
        
        
    }
    
    @objc func addBlurScreenWhenUseBio() {
        
        
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add the blur effect view above the view hierarchy
        self.view.addSubview(blurEffectView!)
        
    }
    
    func removeBlurEffect() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
    
    @objc func didTappedScan(_ sender : UIButton){
        
        
        self.addBlurScreenWhenUseBio()
        FingerPrintAndFaceID.shared.fingerPrintFaceID({ (check) in
            switch check {
            case .success(_):
                
                DispatchQueue.main.async {
                    
                    
                    self.removeBlurEffect()
                }
                
                break
            case .failure( _):
                
                DispatchQueue.main.async {
                    self.removeBlurEffect()
                    
                }
                
                break
            case .no:
                DispatchQueue.main.async {
                    self.removeBlurEffect()
                    
                }
                break
            }
        })
        
        
    }
    
    func checkBackTranscation(tranId: String, status: Int){
        
        
        
    }
    
    
    @objc func backBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func didFailedVerify(){
        Loading.shared.hideLoading()
        
        DispatchQueue.main.async {
            self.shakeStackView()
            UIDevice.vibrate()
            self.label1.txtFeild.text = ""
            self.label2.txtFeild.text = ""
            self.label3.txtFeild.text = ""
            self.label4.txtFeild.text = ""
            self.label5.txtFeild.text = ""
            self.label6.txtFeild.text = ""
            self.getPasscodeOne.removeAll()
            
        }
    }
    
    func shakeStackView() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.07
        shakeAnimation.repeatCount = 2
        shakeAnimation.autoreverses = true
        
        let fromPoint = CGPoint(x: self.stackViewTextField.center.x - 10, y: stackViewTextField.center.y)
        let toPoint = CGPoint(x: stackViewTextField.center.x + 10, y: stackViewTextField.center.y)
        
        shakeAnimation.fromValue = NSValue(cgPoint: fromPoint)
        shakeAnimation.toValue = NSValue(cgPoint: toPoint)
        
        stackViewTextField.layer.add(shakeAnimation, forKey: "position")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    func setUpKeybords() {
        
        view.addSubview(imgViewBGBehine)
        imgViewBGBehine.translatesAutoresizingMaskIntoConstraints = false
        imgViewBGBehine.contentMode = .scaleAspectFit
        
        view.addSubview(imgViewBG)
        imgViewBG.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stackViewTextField)
        stackViewTextField.translatesAutoresizingMaskIntoConstraints = false
        stackViewTextField.axis = .horizontal
        stackViewTextField.distribution = .fillEqually
        stackViewTextField.spacing = 14
        
        view.addSubview(KeyBoradView)
        KeyBoradView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(inputLabel)
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imgProfile)
        imgProfile.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(ForgotPasswordButton)
        ForgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
   
    func setupView() {
        
        imgViewBGBehine.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imgViewBGBehine.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive  = true
        imgViewBGBehine.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imgViewBGBehine.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        imgViewBG.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imgViewBG.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive  = true
        imgViewBG.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imgViewBG.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        label1.heightAnchor.constraint(equalToConstant: 16).isActive = true
        label1.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        
        
        inputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65).isActive = true
        inputLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        

        stackViewTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackViewTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100).isActive = true
        
        KeyBoradView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        KeyBoradView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        KeyBoradView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        ForgotPasswordButton.bottomAnchor.constraint(equalTo: KeyBoradView.topAnchor, constant: 0).isActive = true
        ForgotPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -43).isActive = true
        //        }
        
    }
    
    @objc func didTapForgotPassword(_ sender : UIButton){
        
        
        
    }
}




import AudioToolbox

extension UIDevice {
    
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
    
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        print("Vibrated")
    }
    
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        let modelMapping: [String: String] = [
            "iPhone1,1": "iPhone 2G",
            "iPhone1,2": "iPhone 3G",
            "iPhone2,1": "iPhone 3GS",
            "iPhone3,1": "iPhone 4",
            "iPhone3,2": "iPhone 4",
            "iPhone3,3": "iPhone 4",
            "iPhone4,1": "iPhone 4S",
            "iPhone5,1": "iPhone 5",
            "iPhone5,2": "iPhone 5",
            "iPhone5,3": "iPhone 5c",
            "iPhone5,4": "iPhone 5c",
            "iPhone6,1": "iPhone 5s",
            "iPhone6,2": "iPhone 5s",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone7,2": "iPhone 6",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE",
            "iPhone9,1": "iPhone 7",
            "iPhone9,3": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus",
            "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8",
            "iPhone10,4": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus",
            "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X",
            "iPhone10,6": "iPhone X",
            "iPhone11,2": "iPhone XS",
            "iPhone11,4": "iPhone XS Max",
            "iPhone11,6": "iPhone XS Max",
            "iPhone11,8": "iPhone XR",
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone12,8": "iPhone SE (2nd generation)",
            "iPhone13,1": "iPhone 12 mini",
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,4": "iPhone 12 Pro Max",
            "iPad1,1": "iPad",
            "iPad2,1": "iPad 2",
            "iPad2,2": "iPad 2",
            "iPad2,3": "iPad 2",
            "iPad2,4": "iPad 2",
            "iPad3,1": "iPad (3rd generation)",
            "iPad3,2": "iPad (3rd generation)",
            "iPad3,3": "iPad (3rd generation)",
            "iPad3,4": "iPad (4th generation)",
            "iPad3,5": "iPad (4th generation)",
            "iPad3,6": "iPad (4th generation)",
            "iPad6,11": "iPad (5th generation)",
            "iPad6,12": "iPad (5th generation)",
            "iPad7,5": "iPad (6th generation)",
            "iPad7,6": "iPad (6th generation)",
            "iPad7,11": "iPad (7th generation)",
            "iPad7,12": "iPad (7th generation)",
            "iPad11,6": "iPad (8th generation)",
            "iPad11,7": "iPad (8th generation)",
            "iPad12,1": "iPad (9th generation)",
            "iPad12,2": "iPad (9th generation)"
        ]
        
        if let model = modelMapping[identifier] {
            return model
        }
        
        return identifier
    }
}
