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
    
    @IBAction func pinchImage(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let currentScale = fotoCartaImageView.frame.size.width / fotoCartaImageView.bounds.size.width
            var newScale = sender.scale * currentScale
            
            // Limita el valor mínimo y máximo de la escala
            newScale = max(newScale, 1.0)
            newScale = min(newScale, 3.0)
            
            // Aplica la transformación de escala a la imagen
            let transform = fotoCartaImageView.transform.scaledBy(x: newScale, y: newScale)
            fotoCartaImageView.transform = transform

            sender.scale = 1.0
        }
    }
    
}
