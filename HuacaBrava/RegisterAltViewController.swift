//
//  RegisterAltViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 14/10/23.
//

import UIKit
import Firebase

class RegisterAltViewController: UIViewController {

    @IBOutlet weak var fondoImageView: UIImageView!
    @IBOutlet weak var miView: UIView!
    
    @IBOutlet weak var nombresTextField: UITextField!
    @IBOutlet weak var apellidosTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmarPassTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        confirmarPassTextField.isSecureTextEntry = true
        
        // Configura el radio de las esquinas del UIView
        miView.layer.cornerRadius = 10 // Ajusta el valor según tus preferencias
        miView.layer.masksToBounds = true
    }

    @IBAction func continuarRegistro(_ sender: Any) {
        let nombres = nombresTextField.text!
        let apellidos = apellidosTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let confirm = confirmarPassTextField.text!
        if nombres.isEmpty, apellidos.isEmpty, email.isEmpty, password.isEmpty, confirm.isEmpty {
            self.openAlert(titulo: "Error", mensaje: "Debe ingresar todos sus credenciales.")
        } else if confirm != password {
            self.openAlert(titulo: "Error", mensaje: "La contraseña no coincide en los dos campos.")
        } else {
            self.registerAuth(nombres: nombres, apellidos: apellidos, email: email, password: password)
        }
    }
    
    func openAlert(titulo: String, mensaje: String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}

extension RegisterAltViewController {
    func registerAuth(nombres: String, apellidos: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let user = result {
                let uid = user.user.uid
                self.registerFirestore(nombres: nombres, apellidos: apellidos, email: email, uid: uid)
                self.openAlert(titulo: "Registro correcto", mensaje: "Usted ya puede ingresar al sistema.")
            } else {
                print("Error")
            }
        }
    }
    func registerFirestore(nombres: String, apellidos: String, email: String, uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "nombres": nombres,
            "apellidos": apellidos,
            "email": email
        ]) { error in
            if let e = error {
                print("Se presento un error: \(e)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
