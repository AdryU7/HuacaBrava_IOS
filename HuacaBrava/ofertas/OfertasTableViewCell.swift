//
//  OfertasTableViewCell.swift
//  HuacaBrava
//
//  Created by DAMII on 29/11/23.
//

import UIKit

class OfertasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fotoOfertaImageView: UIImageView!
    @IBOutlet weak var nombreOfertaLabel: UILabel!
    @IBOutlet weak var precioOfertaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
