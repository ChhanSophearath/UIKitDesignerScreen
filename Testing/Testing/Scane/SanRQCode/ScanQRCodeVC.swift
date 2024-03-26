//
//  ScanQRCodeVC.swift
//  IQ
//
//  Created by Rath! on 9/2/24.
//

import UIKit



import Foundation
import AVFoundation
import UIKit

class ScanQRCodeVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var picker = UIImagePickerController()
    let metadataOutput = AVCaptureMetadataOutput()
    var viewFrame: CGRect = .zero
    var yCoordinate: CGFloat = 150
    var hightPath: CGFloat = 358
    let leftMargin: CGFloat = 50
    
    let x: CGFloat = (UIScreen.main.bounds.width-300)/2
    let y: CGFloat = 250
    let width: CGFloat = 300
    
    var scanRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        title = "Scan QR Code"
        
        
        scanRect = CGRect(x: x, y: y, width: width, height: width)
        
        view.backgroundColor = UIColor.white
        self.viewFrame = view.layer.bounds
        self.hightPath = (viewFrame.height * 40) / 100
        self.yCoordinate = (viewFrame.height * 18) / 100
        
        self.setupVideoCapture()
        self.setupPreviewLayer()
        self.startScanAnimate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        if captureSession?.isRunning == false {
            DispatchQueue.global(qos: .background).async { [self] in
                //MARK: Open camera
                self.captureSession.startRunning()
                //MARK: Set scan frame view camera previewLayer
                metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scanRect)
            }
            self.startScanAnimate()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewFrame = view.layer.bounds
        previewLayer.frame = viewFrame
    }
    
    let titleScanLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Scan QR"
        return label
    }()
    
    let subTitleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Align frame with QR code"
        return label
    }()
    
    let flashButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "flash-btn"), for: .normal)
        return btn
    }()
    
    let flashTitleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Flash"
        return label
    }()
    
    let uploadQRButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "upload-qr-btn"), for: .normal)
        return btn
    }()
    
    let uploadQRTitleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Upload QR"
        return label
    }()
    
    let scannerLine: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "scanner-line")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    func setupVideoCapture() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
    }
    
    func setupPreviewLayer() {
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.previewLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer!)
        
        let overlay = createOverlay()
        self.view.addSubview(overlay)
        self.setupView()
        
    }
    
    func setupView() {
        let maginWidth: CGFloat = 55
        let titleLabelHeight: CGFloat = ((3.34 * viewFrame.size.height) / 100)
        let buttonHeight: CGFloat = 65
        
        self.titleScanLbl.frame = CGRect(x: leftMargin, y: yCoordinate - ((11.16 * viewFrame.size.height) / 100), width: viewFrame.size.width - (leftMargin * 2), height: titleLabelHeight)
        view.addSubview(titleScanLbl)
        
        self.subTitleLbl.frame = CGRect(x: leftMargin, y: titleScanLbl.frame.maxY + 10, width: viewFrame.size.width - (leftMargin * 2), height: titleLabelHeight)
        view.addSubview(subTitleLbl)
        
        flashButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flashButton)
        flashButton.topAnchor.constraint(equalTo: view.topAnchor, constant: yCoordinate + hightPath + 20).isActive = true
        flashButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -maginWidth).isActive = true
        flashButton.widthAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        flashButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        flashButton.addTarget(self, action: #selector(self.flashButtonClicked), for: .touchUpInside)
        
        flashTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flashTitleLbl)
        flashTitleLbl.topAnchor.constraint(equalTo: flashButton.bottomAnchor).isActive = true
        flashTitleLbl.centerXAnchor.constraint(equalTo: flashButton.centerXAnchor).isActive = true
        
        uploadQRButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uploadQRButton)
        uploadQRButton.topAnchor.constraint(equalTo: view.topAnchor, constant: yCoordinate + hightPath + 20).isActive = true
        uploadQRButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: maginWidth).isActive = true
        uploadQRButton.widthAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        uploadQRButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        uploadQRButton.addTarget(self, action: #selector(self.uploadQRClicked), for: .touchUpInside)
        
        uploadQRTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uploadQRTitleLbl)
        uploadQRTitleLbl.topAnchor.constraint(equalTo: uploadQRButton.bottomAnchor).isActive = true
        uploadQRTitleLbl.centerXAnchor.constraint(equalTo: uploadQRButton.centerXAnchor).isActive = true
        
        self.scannerLine.frame = CGRect(x: 40, y: self.yCoordinate + (self.hightPath - 45), width: self.viewFrame.size.width - 80, height: 3)
        view.addSubview(scannerLine)
        scannerLine.backgroundColor = .red
    }
    
    func createOverlay() -> UIView {
        
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = .orange.withAlphaComponent(0.5)
        let path = CGMutablePath()
        path.addRoundedRect(in: scanRect, cornerWidth: 5, cornerHeight: 5)
        path.closeSubpath()
        

        //MARK: Set frame createFrame
       let createFrame = createFrame()
        createFrame.position = CGPoint(x: x - 20, y: y - 20)
        overlayView.layer.addSublayer(createFrame)
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 7
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.green.cgColor
        
        overlayView.layer.addSublayer(shape)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        return overlayView
    }
    
    
    
    func createFrame() -> CAShapeLayer {
            let height: CGFloat = width + 40
        
        let width: CGFloat = width + 40
           
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 5, y: 55))
            path.addLine(to: CGPoint(x: 5, y: 5))
            path.addLine(to: CGPoint(x: 55, y: 5))
        
        
            path.move(to: CGPoint(x: height - 55, y: 5))
            path.addLine(to: CGPoint(x: height - 5, y: 5))
            path.addLine(to: CGPoint(x: height - 5, y: 55))
        
            path.move(to: CGPoint(x: 5, y: width - 55))
            path.addLine(to: CGPoint(x: 5, y: width - 5))
            path.addLine(to: CGPoint(x: 55, y: width - 5))
        
            path.move(to: CGPoint(x: width - 55, y: height - 5))
            path.addLine(to: CGPoint(x: width - 5, y: height - 5))
            path.addLine(to: CGPoint(x: width - 5, y: height - 55))
        
            let shape = CAShapeLayer()
            shape.path = path.cgPath
            shape.strokeColor = UIColor.white.cgColor
            shape.lineWidth = 5
            shape.fillColor = UIColor.clear.cgColor
            return shape
        }
    
    
    

    
    @objc func startScanAnimate() {
        self.scannerLine.frame = CGRect(x: 40, y: y + (self.hightPath - 40 - 55), width: self.viewFrame.size.width - 80, height: 3)
        UIView.animate(withDuration: 2, delay: 1, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.scannerLine.frame = CGRect(x: 40, y: self.y + 35, width: self.viewFrame.size.width - 80, height: 3)
        }, completion: nil)
    }

    func stopScanAnimate() {
        self.scannerLine.layer.removeAllAnimations()
    }
    
    
    @objc func flashButtonClicked() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if device.torchMode == .off {
                    device.torchMode = .on
                    startScanAnimate()
                } else {
                    stopScanAnimate()
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    @objc func uploadQRClicked() {
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported",
                                   message: "Device not supported",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        dismiss(animated: true)
    }
    
    func found(code: String) {
        //        if let dic = convertToDictionary(text: code) {
        //            self.paymentQR(userDic: dic)
        //        }
    }
    
    func parseQR(imageData: UIImage) -> String {
        guard let image = CIImage(image: imageData) else {
            return ""
        }
        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        let features = detector?.features(in: image) ?? []
        var qrCodeLink = ""
        for feature in features as! [CIQRCodeFeature] {
            qrCodeLink += feature.messageString!
        }
        return qrCodeLink
    }
    
    func paymentQR(userDic: [String: String]) {
        
    }
    
    func convertToDictionary(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension ScanQRCodeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let chosenImage = info[.originalImage] as? UIImage
        else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let parseQRData = parseQR(imageData: chosenImage)
        print("string result -->:", parseQRData)
        //        if let dic = convertToDictionary(text: parseQRData) {
        //            print("parseQR ==> ", dic)
        //            self.paymentQR(userDic: dic)
        //        }
        picker.dismiss(animated: true, completion: nil)
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if captureSession?.isRunning == false {
            self.startScanAnimate()
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
}
