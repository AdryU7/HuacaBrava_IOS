//
//  OpcionesViewController.swift
//  HuacaBrava
//
//  Created by Christian  on 15/08/1402 AP.
//

import UIKit
import Firebase

class OpcionesViewController: UIViewController {

    @IBOutlet weak var nombreApellidoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nombres = UserDefaults.standard.string(forKey: "login_nombres")
        let apellidos = UserDefaults.standard.string(forKey: "login_apellidos")
        let email = UserDefaults.standard.string(forKey: "login_email")
        nombreApellidoLabel.text = "\(nombres ?? "") \(apellidos ?? "")"
        emailLabel.text = email ?? ""
    }
    
    @IBAction func logOut(_ sender: Any) {
        self.openAlertLogout()
    }
    
    func openAlertLogout() {
        let alert = UIAlertController(title: "Aviso", message: "¿Está seguro que desea cerrar sesión?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Sí, cerrar sesión", style: .destructive) { action in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            self.goToLogin()
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "No, cancelar", style: .cancel))
        present(alert, animated: true)
    }
    
    func goToLogin() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginAltViewController") as! LoginAltViewController
        let navigation = UINavigationController(rootViewController: loginViewController)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true)
    }
}
