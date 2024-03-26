//
//  TableView.swift
//  Testing
//
//  Created by Rath! on 22/2/24.
//

import UIKit



class StretchyVC: UIViewController {

 let  tableView =  UITableView()

    let imageView = UIImageView()
    var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage.init(named: "img")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        tableView.tableHeaderView = imageView
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubview(tableView)
        
        
        
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.darkGray
        
        self.tableView.backgroundColor = .clear
        self.view.bringSubviewToFront(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension StretchyVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        
    
        cell.textLabel?.text = "Testing"

        return cell
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if self.lastContentOffset < scrollView.contentOffset.y {
            let y = 220 - (scrollView.contentOffset.y + 220)
            let height = min(max(y, 60), 220)
            if height >= 128 {
                imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height + 70)
            }
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            let y = 300 - (scrollView.contentOffset.y + 300)
            let height = min(max(y, 60), 400)
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height + 80)
        }
    }
}
