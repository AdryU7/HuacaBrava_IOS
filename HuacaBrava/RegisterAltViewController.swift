//
//  RegisterAltViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 14/10/23.
//

import UIKit

class RegisterAltViewController: UIViewController {

    @IBOutlet weak var fondoImageView: UIImageView!
    @IBOutlet weak var miView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura el radio de las esquinas del UIView
        miView.layer.cornerRadius = 10 // Ajusta el valor según tus preferencias
        miView.layer.masksToBounds = true
    }

}
