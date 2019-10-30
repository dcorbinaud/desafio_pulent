//
//  ViewController.swift
//  desafio_pulent
//
//  Created by bild on 10/29/19.
//

import UIKit

class ViewController: UITableViewController{
    
    var source: ituneData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network = Network()
        self.source = network.jsonRequest(param: "in+utero")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.source?.results {
            return list.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainTableViewCell {
            if let data = self.source?.results?[indexPath.row] {
                cell.cellData = data
                cell.updateView()
            }
            
            
            return cell
        }
        
        return UITableViewCell()
    }


}

