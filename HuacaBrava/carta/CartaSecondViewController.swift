//
//  CartaSecondViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 7/10/23.
//

import UIKit

class CartaSecondViewController: UIViewController {

    @IBOutlet weak var fotoCartaImageView: UIImageView!
    
    var imagen: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fotoCartaImageView.image = imagen
    }

}
