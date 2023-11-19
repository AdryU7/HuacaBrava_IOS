//
//  LoginAltViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 11/10/23.
//

import UIKit
import Firebase

class LoginAltViewController: UIViewController {

    @IBOutlet weak var miView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configura el radio de las esquinas del UIView
        miView.layer.cornerRadius = 10 // Ajusta el valor según tus preferencias
        miView.layer.masksToBounds = true
        
        if verifyLogin() {
            goToMenu()
        }
    }
    
    func verifyLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: "login_status")
    }
    
    @IBAction func inicioSesionButton(_ sender: Any) {
        let correo = emailTextField.text
        let clave = passwordTextField.text
        if let email = correo, let pass = clave{
            if email.isEmpty, pass.isEmpty {
                showAlert(mensaje: "Debe ingresar sus credenciales")
            } else if email.isEmpty{
                showAlert(mensaje: "Ingrese correo")
            } else if pass.isEmpty{
                showAlert(mensaje: "Ingrese clave")
            }else{
                self.loginFirebase(email: email, password: pass)
            }
        }else{
            showAlert(mensaje: "NADA")
        }
    }
    
    func goToMenu(){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewScreen = storyBoard.instantiateViewController(withIdentifier: "TabBarMenu") as! MenuViewController
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

// Firebase
extension LoginAltViewController {
    func loginFirebase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let user = result {
                let uid = user.user.uid
                self.getAccountInfo(uid: uid)
            } else {
                self.showAlert(mensaje: "Email y/o password invalidos, por favor vuelva a ingresar sus credenciales correctamente")
            }
        }
    }
    func getAccountInfo(uid: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        docRef.getDocument(completion: { (document, error) in
            if let d = document, d.exists {
                let data = d.data()
                let email = data?["email"] as? String ?? ""
                let nombres = data?["nombres"] as? String ?? ""
                let apellidos = data?["apellidos"] as? String ?? ""
                
                self.saveSuccessfulLogin(nombres: nombres, apellidos: apellidos, email: email)
                self.goToMenu()
            }
        })
    }
}

extension LoginAltViewController {
    func saveSuccessfulLogin(nombres: String, apellidos: String, email: String) {
        let defaults = UserDefaults.standard
        defaults.set(nombres, forKey: "login_nombres")
        defaults.set(apellidos, forKey: "login_apellidos")
        defaults.set(email, forKey: "login_email")
        defaults.set(true, forKey: "login_status")
    }
}
