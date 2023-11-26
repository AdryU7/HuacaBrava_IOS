//
//  CarritoTableViewCell.swift
//  HuacaBrava
//
//  Created by DAMII on 28/10/23.
//

import UIKit

class CarritoTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreCarritoLabel: UILabel!
    @IBOutlet weak var precioCarritoLabel: UILabel!
    @IBOutlet weak var cantidadCarritoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
