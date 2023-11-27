//
//  AdminEmpleadoTableViewCell.swift
//  HuacaBrava
//
//  Created by DAMII on 27/09/23.
//

import UIKit

class AdminEmpleadoTableViewCell: UITableViewCell {

    @IBOutlet weak var nombresAdminEmpleadoLabel: UILabel!
    @IBOutlet weak var apellidosAdminEmpleadoLabel: UILabel!
    @IBOutlet weak var dniAdminEmpleadoLabel: UILabel!
    @IBOutlet weak var ocupacionAdminEmpleadoLabel: UILabel!
    @IBOutlet weak var fotoCarnetAdminEmpleadoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
