//
//  ListViewController.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 1/2/24.
//

import UIKit


class ListViewController: UIViewController, UISearchBarDelegate {
    
    private let searchBar = UISearchBar()
    private let listViewController: [UIViewController] = [
        PopupVC(),
      
                                                          NotificationVC(),
                                                          ScanQRCodeVC(),
                                                          ExpandedMultipleSectionVC(),
                                                          ExspandSingleSectionVC(),
                                                          ButtonOnKeyboradVC(),
                                                          PageVC(),
                                                          PercentageVC(),
                                                          SearchTransationVC(),
                                                          ObserverNotificationVC(),
                                                          TableViewAotoScrollVC(),
                                                          SwipingItemsVC(),
                                                          MenuListDragDropVC(),
                                                          PassCodeVC(),
                                                          OriginalKeyBoradVC(),
                                                          PasscodeViewControllerVC()
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List ViewController"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        // Set up the search bar
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        UINavigationBar.appearance().tintColor = .red
        
        // Set up the cancel button
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = cancelButton
        
        setupUIView()
    }
    
    @objc func cancelButtonTapped() {
        // Handle the cancel button action here
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        //        tableView.backgroundColor = .red
        tableView.register(TableListCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    
    
    func setupUIView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }
}

extension ListViewController :  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableListCell
        let listViewControllerString = listViewController.map { String(describing: $0) }
        
        let modifiedString = listViewControllerString[indexPath.row].replacingOccurrences(of: "<UIkitDesignScreen.", with: "")
        
        if let range = modifiedString.range(of: "VC") {
            let modifiedString = modifiedString.prefix(upTo: range.lowerBound)
            cell.textLabel?.text = "\(indexPath.row ) - " +  modifiedString.description
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushViewController(listViewController[indexPath.row])
    }
    
}


