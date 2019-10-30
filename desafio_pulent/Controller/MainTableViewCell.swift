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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateView() {
        
        if let data = self.cellData {
            self.Name.text = data.trackName
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
