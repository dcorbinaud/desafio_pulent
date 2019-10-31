//
//  ViewController.swift
//  desafio_pulent
//
//  Created by bild on 10/29/19.
//
import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var source: ituneData? = nil
    var list: [song]? = nil
    var searchText: String = ""
    var limit = 20
    var totalEntries = 0
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumDetails" {
            if let indexpPath = self.tableView.indexPathForSelectedRow{
                if let viewController = segue.destination as? AlbumViewController {
                    let network = Network()
                    if let data = network.albumRequest(id: source?.results?[indexpPath.row].collectionId ?? 0) {
                        viewController.data = data
                    }
                    
                }
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.list {
            return list.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let arrayList = self.list {
            if indexPath.row == arrayList.count - 1 {
                if arrayList.count < totalEntries {
                    
                    self.page += 1
                    
                    let newLimit = self.limit * self.page
                    
                    if newLimit <= self.totalEntries {
                        self.list = self.source?.results?.suffix(newLimit)
                    } else {
                        self.list = self.source?.results
                    }
                    
                    self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
                }
            }
        }
        
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText.replacingOccurrences(of: " ", with: "+")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let network = Network()
        self.source = network.jsonRequest(param: searchText)
        
        if let list = self.source?.results {
            self.totalEntries = list.count
            
            if self.limit <= self.totalEntries {
                self.list = list.suffix(self.limit)
            } else {
                self.list = list
            }

        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.view.endEditing(true)
    }
    
}
