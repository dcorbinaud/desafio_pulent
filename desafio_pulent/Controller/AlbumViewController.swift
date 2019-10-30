//
//  AlbumViewController.swift
//  desafio_pulent
//
//  Created by bild on 10/30/19.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var trackTableView: UITableView!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    var data: ituneData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Album"

        albumName.text = data?.results?.first?.collectionName ?? ""
        bandName.text = data?.results?.first?.artistName ?? ""
        
        let network = Network()
        if let imageData = network.imageRequest(url: data?.results?.first?.artworkUrl100 ?? "") {
            DispatchQueue.main.async {
                self.albumImage.image = UIImage(data: imageData)
            }
        }
        
        self.trackTableView.delegate = self
        self.trackTableView.dataSource = self
        
        self.trackTableView.tableFooterView = UIView()
        
    }

}

extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data?.results {
            return data.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTracks", for: indexPath) as? AlbumTracksTableViewCell {
            if let data = self.data?.results?[indexPath.row] {
                cell.cellData = data
                cell.updateView()
            }
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
