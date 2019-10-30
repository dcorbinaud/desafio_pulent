//
//  AlbumTracksTableViewCell.swift
//  desafio_pulent
//
//  Created by bild on 10/30/19.
//

import UIKit

class AlbumTracksTableViewCell: UITableViewCell {
    var cellData: song?
    @IBOutlet weak var trackName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateView(){
        if let data = cellData {
            trackName.text = data.trackName
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
