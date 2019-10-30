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
    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network = Network()
        self.source = network.jsonRequest(param: "in+utero")
        
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
        if let list = self.source?.results {
            return list.count
        } else {
            return 0
        }
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        self.view.endEditing(true)
    }
    
}
