//
//  TableViewAotoScrollVC.swift
//  Testing
//
//  Created by Rath! on 14/2/24.
//

import UIKit

class TableViewAotoScrollVC: UIViewController {
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.frame = view.bounds
        tableView.frame = CGRect(x: view.bounds.origin.x, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top)
        view.addSubview(tableView)
        
        tableView.bounces = false //MARK: for check row of cell full or not full
        tableView.backgroundColor = .orange
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
}


extension TableViewAotoScrollVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}


//import UIKit

import UIKit

//class ViewControllerOne: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Create a menu item
//        let menuItem = UIMenuItem(title: "Save", action: #selector(saveAction))
//        
//        // Create a submenu
//        let subMenu = UIMenu(title: "Edit", children: [menuItem])
//        
//        // Create a main menu
//        let mainMenu = UIMenu(title: "Main Menu", children: [subMenu])
//        
//        // Set the main menu as the menu items for the UIMenuController
//        UIMenuController.shared.menu = mainMenu
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        // Make the menu visible
//        UIMenuController.shared.showMenu(from: view, rect: view.bounds)
//    }
//    
//    // Action method for the menu item
//    @objc func saveAction() {
//        print("Save action triggered")
//    }
//}
