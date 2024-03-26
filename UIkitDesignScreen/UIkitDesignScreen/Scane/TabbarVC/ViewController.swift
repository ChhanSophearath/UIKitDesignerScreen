//
//  ViewController.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 30/1/24.
//

import UIKit




class ViewController: UIViewController, UISearchBarDelegate {
    
    
    var didSelect:(()->())?
    
    private let searchBar = UISearchBar()
    private let listViewController: [String] = ["Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello","Hello"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavicationBar()
        setupUIView()
    }
    
    
    func setupNavicationBar(){
        // Set up the search bar
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        UINavigationBar.appearance().tintColor = .red
        
        // Set up the cancel button
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    
    @objc func cancelButtonTapped() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        tableView.register(TableListCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setupUIView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }
    
}

extension ViewController :  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewController.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableListCell
        cell.textLabel?.text = listViewController[indexPath.row] + " : \(indexPath.row)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //        didSelect?()
        
        let test = NotificationVC()
        
        self.navigationController?.pushViewController(test, animated: true)
        
    }
    
}


class TableListCell : UITableViewCell{
    static let cell = "cell"
}
