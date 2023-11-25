//
//  ProductoTableViewCell.swift
//  HuacaBrava
//
//  Created by DAMII on 22/11/23.
//

import UIKit

class ProductoTableViewCell: UITableViewCell {

    @IBOutlet weak var fotoProdImageView: UIImageView!
    @IBOutlet weak var nombreProdLabel: UILabel!
    @IBOutlet weak var precioAnteriorProdLabel: UILabel!
    @IBOutlet weak var precioActualProdLabel: UILabel!
    @IBOutlet weak var stockProdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
