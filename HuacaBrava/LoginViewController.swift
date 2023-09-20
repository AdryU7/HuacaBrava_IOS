//
//  LoginViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 20/09/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func inicioSesionButton(_ sender: Any) {
        var correo = emailTextField.text
        var clave = passwordTextField.text
        if let email = correo, let pass = clave{
            if email.isEmpty{
                showAlert(mensaje: "Ingrese correo")
            } else if pass.isEmpty{
                showAlert(mensaje: "Ingrese clave")
            }else{
                goToMeu()
            }
        }else{
            showAlert(mensaje: "NADA")
        }
    }
    
    func goToMeu(){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewScreen = storyBoard.instantiateViewController(withIdentifier: "TabBarMenu") as!
        MenuViewController
        viewScreen.modalPresentationStyle = .fullScreen
        self.present(viewScreen, animated: true, completion: nil)
    }
    func showAlert(mensaje : String){
        let alert = UIAlertController(title: "ERROR", message: mensaje, preferredStyle: .alert)
        let button = UIAlertAction(title: "Entendido", style:.default)
        alert.addAction(button)
        self.present(alert, animated: true)
    }
}
