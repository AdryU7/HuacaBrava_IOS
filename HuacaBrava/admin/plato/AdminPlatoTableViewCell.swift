//
//  AdminPlatoTableViewCell.swift
//  HuacaBrava
//
//  Created by DAMII on 27/09/23.
//

import UIKit

class AdminPlatoTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreAdminPlatoLabel: UILabel!
    @IBOutlet weak var descripcionAdminPlatoLabel: UILabel!
    @IBOutlet weak var precioAdminPlatoLabel: UILabel!
    @IBOutlet weak var stockAdminPlatoLabel: UILabel!
    @IBOutlet weak var fotoAdminPlatoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
