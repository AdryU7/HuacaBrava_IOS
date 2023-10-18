//
//  CartaAltTableViewCell.swift
//  HuacaBrava
//
//  Created by DAMII on 18/10/23.
//

import UIKit

class CartaAltTableViewCell: UITableViewCell {

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
