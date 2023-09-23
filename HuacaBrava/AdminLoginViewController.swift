//
//  AdminLoginViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 23/09/23.
//

import UIKit

class AdminLoginViewController: UIViewController {

    @IBOutlet weak var dniTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ingresarButton(_ sender: Any) {
        let dni = dniTextField.text
        let email = emailTextField.text
        let pass = passTextField.text
        
        if let dni1 = dni, let email1 = email, let pass1 = pass {
            if dni1.isEmpty {
                showAlert(mensaje: "Ingresar DNI")
            } else if email1.isEmpty {
                showAlert(mensaje: "Ingresar email")
            } else if pass1.isEmpty {
                showAlert(mensaje: "Ingresar password")
            } else {
                goToAdminMenu()
            }
        } else {
            showAlert(mensaje: "nada")
        }
    }
    
    func goToAdminMenu() {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewScreen2 = storyBoard.instantiateViewController(withIdentifier: "TabBarMenu") as!
        AdminViewController
        viewScreen2.modalPresentationStyle = .fullScreen
        self.present(viewScreen2, animated: true, completion: nil)
    }
    
    func showAlert(mensaje: String) {
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let button = UIAlertAction(title: "Entendido", style: .default)
        alert.addAction(button)
        self.present(alert, animated: true)
    }
    
}
