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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nombres = UserDefaults.standard.string(forKey: "login_nombres")
        let apellidos = UserDefaults.standard.string(forKey: "login_apellidos")
        let email = UserDefaults.standard.string(forKey: "login_email")
        nombreApellidoLabel.text = "\(nombres ?? "") \(apellidos ?? "")"
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        self.goToLogin()
    }
    
    func goToLogin() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginAltViewController") as! LoginAltViewController
        let navigation = UINavigationController(rootViewController: loginViewController)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true)
    }
}
