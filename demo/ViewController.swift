//
//  ViewController.swift
//  demo
//
//  Created by Krishna on 13/10/20.
//  Copyright © 2020 Saksha. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    var tableView = UITableView()
    var data = [JsonModel]()
    var jsonViewModel = JsonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        
        
        jsonViewModel.fetchData { [weak self] rows in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
       
    }
    
    
    func updateUI() {
           tableView.reloadData()
       }
    


}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonViewModel.rowsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = jsonViewModel.rowsArr[indexPath.row]
        cell.textLabel?.text = cellData.title
        cell.detailTextLabel?.text = cellData.description
        cell.imageView?.sd_setImage(with: URL(string: cellData.imageHref), completed: nil)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate { }

