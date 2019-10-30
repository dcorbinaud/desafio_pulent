//
//  MainTableViewCell.swift
//  desafio_pulent
//
//  Created by bild on 10/29/19.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    var cellData: song?
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateView() {
        
        if let data = self.cellData {
            self.Name.text = data.trackName
            
            if let price = data.trackPrice {
                self.price.text = "$\(price)"
            }else{
                self.price.text = ""
            }
            
            let network = Network()
            if let imageData = network.imageRequest(url: data.artworkUrl60) {
                DispatchQueue.main.async {
                    self.artworkImage.image = UIImage(data: imageData)
                }
            }
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
