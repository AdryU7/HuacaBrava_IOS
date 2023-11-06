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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura el radio de las esquinas del UIView
        miView.layer.cornerRadius = 10 // Ajusta el valor según tus preferencias
        miView.layer.masksToBounds = true
    }

    @IBAction func continuarRegistro(_ sender: Any) {
        let nombres = nombresTextField.text!
        let apellidos = apellidosTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        self.registerAuth(nombres: nombres, apellidos: apellidos, email: email, password: password)
    }
    
}

extension RegisterAltViewController {
    func registerAuth(nombres: String, apellidos: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let user = result {
                let uid = user.user.uid
                self.registerFirestore(nombres: nombres, apellidos: apellidos, email: email, uid: uid)
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
                print("Se presento un error")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
