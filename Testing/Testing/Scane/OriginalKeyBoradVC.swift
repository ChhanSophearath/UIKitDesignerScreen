//
//  OriginalKeyBoradVC.swift
//  Testing
//
//  Created by Rath! on 29/2/24.
//

import UIKit
import LocalAuthentication

class OriginalKeyBoradVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
      
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        authenticateWithPasscode()
    }
    

    func authenticateWithPasscode() {
        let context = LAContext()
        var error: NSError?

        // Check if passcode authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate with your passcode"
            
            // Perform passcode authentication
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success {
                    // Passcode authentication succeeded
                    DispatchQueue.main.async {
                        // Perform any UI updates or navigate to the next screen
                    }
                } else {
                    // Passcode authentication failed
                    if let error = error as NSError? {
                        // Handle the error appropriately (e.g., display an error message)
                        print("Passcode authentication failed: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            // Passcode authentication is not available on the device
            if let error = error as NSError? {
                // Handle the error appropriately (e.g., display an error message)
                print("Passcode authentication not available: \(error.localizedDescription)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


import UIKit

class PasscodeViewControllerVC: UIViewController {

    
    let passcodeKeyboardView = PasscodeKeyboardView()
    
    override func loadView() {
        super.loadView()
        view = passcodeKeyboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
   
}

import UIKit
import UIKit

protocol PasscodeKeyboardDelegate: class {
    func passcodeKeyboard(_ keyboard: PasscodeKeyboardView, didEnterCharacter character: String)
    func passcodeKeyboardDidTapDelete(_ keyboard: PasscodeKeyboardView)
}

class PasscodeKeyboardView: UIView {
    // Define the circular keyboard properties
    private let keyboardRadius: CGFloat = 150.0
    private let keySize: CGFloat = 60.0
    private let deleteButtonSize: CGFloat = 40.0
    
    private var numberButtons: [UIButton] = []
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("⌫", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 0.5 * 40
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: PasscodeKeyboardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupKeyboard()
    }
    
    private func setupKeyboard() {
        backgroundColor = .clear
        
        createNumberButtons()
        
        addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: keySize + 10),
            deleteButton.widthAnchor.constraint(equalToConstant: deleteButtonSize),
            deleteButton.heightAnchor.constraint(equalToConstant: deleteButtonSize)
        ])
        
        for button in numberButtons {
            addSubview(button)
        }
        
        layoutNumberButtons()
        
        // Add target for button taps
        for button in numberButtons {
            button.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        }
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func createNumberButtons() {
        for i in 1...9 {
            let button = UIButton()
            button.setTitle("\(i)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 0.5 * keySize
            button.translatesAutoresizingMaskIntoConstraints = false
            numberButtons.append(button)
        }
    }
    
    private func layoutNumberButtons() {
        let angles: [CGFloat] = [0, 45, 90, 135, 180, 225, 270, 315, 360]
        
        for (index, button) in numberButtons.enumerated() {
            let angle = angles[index] * CGFloat.pi / 180.0
            let x = keyboardRadius + keyboardRadius * cos(angle) - 0.5 * keySize
            let y = keyboardRadius + keyboardRadius * sin(angle) - 0.5 * keySize
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: keySize),
                button.heightAnchor.constraint(equalToConstant: keySize),
                button.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x - keyboardRadius),
                button.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y - keyboardRadius)
            ])
        }
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5),
                                      radius: keyboardRadius,
                                      startAngle: 0,
                                      endAngle: CGFloat.pi * 2,
                                      clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1.0
        
        layer.addSublayer(shapeLayer)
    }
    
    @objc private func numberButtonTapped(_ sender: UIButton) {
        guard let character = sender.titleLabel?.text else { return }
        delegate?.passcodeKeyboard(self, didEnterCharacter: character)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        delegate?.passcodeKeyboardDidTapDelete(self)
    }
}
