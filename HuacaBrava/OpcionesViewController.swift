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
        showCurrentUser()
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

extension OpcionesViewController {
    func showCurrentUser() {
        let userID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let nombres = data?["nombres"] as? String ?? ""
                let apellidos = data?["apellidos"] as? String ?? ""
                // Aquí deberías tener el nombre, ahora lo puedes mostrar en el Label
                self.nombreApellidoLabel.text = "\(nombres) \(apellidos)"
            } else {
                print("Error al obtener el documento")
            }
        }
    }
}
