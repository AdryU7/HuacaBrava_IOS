//
//  CartaDetalleViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 18/10/23.
//

import UIKit

class CartaDetalleViewController: UIViewController {

    var carta: CartaAlt?
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let card = carta {
            tituloLabel.text = card.titulo
            descripcionLabel.text = card.descripcion
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let isDetailViewControllerPresented = false
    }

}
