//
//  PedidoViewController.swift
//  HuacaBrava
//
//  Created by Amalia Velasquez Elizalde on 28/11/23.
//

import UIKit

class PedidoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        self.openAlert(titulo: "Aviso", mensaje: "¿Está seguro que desea cancelar el pedido?")
    }
    
    func openAlert(titulo: String, mensaje: String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let action = UIAlertAction(title: "Sí, cancelar", style: .destructive) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "No, continuar", style: .default))
        self.present(alert, animated: true)
    }
    
}
