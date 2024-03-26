////
////  DragDropReorderCollectionViewVC.swift
////  Testing
////
////  Created by Rath! on 22/2/24.
////
//
//import UIKit
//
//
class DragDropReorderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    var collectionView: UICollectionView!
    var items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! MyCollectionViewCell
       
        cell.titleLabel.text = items[indexPath.item]

        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthScreen = (UIScreen.main.bounds.width-10)/3
        return CGSize(width: widthScreen, height: widthScreen)
    }
    
    // MARK: - UICollectionViewDragDelegate
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MyCollectionViewCell else { return [] }
        
        let itemProvider = NSItemProvider(object: items[indexPath.item] as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = cell
        
        return [dragItem]
    }
    
    // MARK: - UICollectionViewDropDelegate
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        let dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        return dropProposal
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                if let cell = item.dragItem.localObject as? MyCollectionViewCell {
                    collectionView.performBatchUpdates({
                        items.remove(at: sourceIndexPath.item)
                        items.insert(cell.titleLabel.text ?? "", at: destinationIndexPath.item)
                        collectionView.deleteItems(at: [sourceIndexPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                    }, completion: { finished in
                        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                    })
                }
            } else {
                let placeholderContext = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "CellIdentifier"))
                
                item.dragItem.itemProvider.loadObject(ofClass: NSString.self, completionHandler: { (object, error) in
                    if let draggedItem = object as? NSString {
                        DispatchQueue.main.async {
                            placeholderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                                self.items.insert(draggedItem as String, at: insertionIndexPath.item)
                                self.collectionView.insertItems(at: [insertionIndexPath])
                            })
                        }
                    }
                })
            }
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        print("Selected item: \(selectedItem)")
        
        // Perform any additional actions based on the selected item
    }
    
}
//
class MyCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        layer.cornerRadius = 10
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    




}


import UIKit
