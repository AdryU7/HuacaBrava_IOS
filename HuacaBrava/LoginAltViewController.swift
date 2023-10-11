//
//  LoginAltViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 11/10/23.
//

import UIKit

class LoginAltViewController: UIViewController {

    @IBOutlet weak var miView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configura el radio de las esquinas del UIView
        miView.layer.cornerRadius = 10 // Ajusta el valor según tus preferencias
        miView.layer.masksToBounds = true
    }
    
    @IBAction func inicioSesionButton(_ sender: Any) {
        let correo = emailTextField.text
        let clave = passwordTextField.text
        if let email = correo, let pass = clave{
            if email.isEmpty{
                showAlert(mensaje: "Ingrese correo")
            } else if pass.isEmpty{
                showAlert(mensaje: "Ingrese clave")
            }else{
                goToMenu()
            }
        }else{
            showAlert(mensaje: "NADA")
        }
    }
    
    func goToMenu(){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewScreen = storyBoard.instantiateViewController(withIdentifier: "TabBarMenu") as!
        MenuViewController
        viewScreen.modalPresentationStyle = .fullScreen
        self.present(viewScreen, animated: true, completion: nil)
    }
    func showAlert(mensaje : String){
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let button = UIAlertAction(title: "Entendido", style:.default)
        alert.addAction(button)
        self.present(alert, animated: true)
    }
    
}
