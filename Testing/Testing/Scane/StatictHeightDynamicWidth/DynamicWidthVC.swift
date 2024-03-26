//
//  DynamicWidthVC.swift
//  Testing
//
//  Created by Rath! on 5/3/24.
//

import UIKit

struct TitleValue{
    var title : UIImage?
    var value : String?
}


class DynamicWidthVC: UIViewController {
    
    var  titleValue : [TitleValue] = []{
        
        didSet{
            DispatchQueue.main.async { [self] in
                collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 20
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let  collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DynamicWidthCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
}

extension  DynamicWidthVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  titleValue.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DynamicWidthCell
        
        let last = collectionView.numberOfItems(inSection: 0) - 1
        
        if last != indexPath.row{
            let data = titleValue[indexPath.row-1]
            cell.imgFile.image = data.title
            cell.labelNameFile.text = data.value
            
        }
        
       
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        uploadButtonTapped()
    }
    
}

extension  DynamicWidthVC: UIDocumentPickerDelegate{
     func uploadButtonTapped() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
       
        guard let fileURL = urls.first else {
                   print("No file selected.")
                   return
               }

               // Get the file name from the URL
               let fileName = fileURL.lastPathComponent
               
               // Create a session configuration
               let config = URLSessionConfiguration.default
               let session = URLSession(configuration: config)
               
               // Create a URL request with the server endpoint
               guard let url = URL(string: "https://your-server-endpoint.com/upload") else {
                   print("Invalid server URL.")
                   return
               }
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               
               // Set the file data as the request body
               do {
                   let fileData = try Data(contentsOf: fileURL)
                   request.httpBody = fileData
               } catch {
                   print("Error reading file data: \(error)")
                   return
               }
               
               // Create a data task to send the request
               let task = session.dataTask(with: request) { (data, response, error) in
                   if let error = error {
                       print("Error uploading file: \(error)")
                   } else {
                       // Handle the server response if needed
                       // ...
                       
                   }
               }
               
               // Start the data task
               task.resume()
    }
    

    
}

 
class DynamicWidthCell : UICollectionViewCell{
    
    
    
    var  nsWidth = NSLayoutConstraint()
    
    let bgView  = UIView()
    let imgFile = UIImageView()
    let labelNameFile = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.layer.cornerRadius = 10
        bgView.backgroundColor = .white
        
        imgFile.backgroundColor = .brown
        imgFile.clipsToBounds = true
        labelNameFile.backgroundColor = .red
        labelNameFile.sizeToFit()
        
        imgFile.translatesAutoresizingMaskIntoConstraints = false
        labelNameFile.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bgView)
        bgView.addSubview(imgFile)
        bgView.addSubview(labelNameFile)
    }
    
    
    func setupConstrain(){
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leftAnchor.constraint(equalTo: leftAnchor),
            bgView.rightAnchor.constraint(equalTo: rightAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 180),

            
            imgFile.topAnchor.constraint(equalTo: bgView.topAnchor),
            imgFile.leftAnchor.constraint(equalTo: bgView.leftAnchor,constant: 10),
            imgFile.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            
            
            labelNameFile.topAnchor.constraint(equalTo: bgView.topAnchor,constant: 10),
            labelNameFile.leftAnchor.constraint(equalTo: imgFile.rightAnchor,constant: 10),
            labelNameFile.rightAnchor.constraint(equalTo: bgView.rightAnchor,constant: -10)
        ])
        
        nsWidth = imgFile.widthAnchor.constraint(equalToConstant: 200)
        nsWidth.isActive = true
    }
}
    
    
    
    
    
    class ContentSizedCollectionView: UICollectionView {
        
        override func layoutSubviews() {
            super.layoutSubviews()
            if bounds.size != intrinsicContentSize {
                self.invalidateIntrinsicContentSize()
            }
        }
        
        override var intrinsicContentSize: CGSize {
            return collectionViewLayout.collectionViewContentSize
        }
    }
    
    



