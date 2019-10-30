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
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://itunes.apple.com/search?term=in+utero&mediaType=music&limit=20")
        let request = URLRequest(url: url!)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            
            guard let data = data else {
                return
            }
            
//            print(String(decoding: data, as: UTF8.self))
            
            let decoder = JSONDecoder()
            do {
                self.source = try decoder.decode(ituneData.self, from: data)
            } catch let catchError {
                print(catchError.localizedDescription)
            }
            
            semaphore.signal()
            
        }
        
        dataTask.resume()
        
        semaphore.wait()
        
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

