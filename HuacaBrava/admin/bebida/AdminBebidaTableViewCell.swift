//
//  AdminBebidaTableViewCell.swift
//  HuacaBrava
//
//  Created by DAMII on 30/09/23.
//

import UIKit

class AdminBebidaTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreAdminBebidaLabel: UILabel!
    @IBOutlet weak var descripcionAdminBebidaLabel: UILabel!
    @IBOutlet weak var precioAdminBebidaLabel: UILabel!
    @IBOutlet weak var stockAdminBebidaLabel: UILabel!
    @IBOutlet weak var fotoAdminBebidaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
