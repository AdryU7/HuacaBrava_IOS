//
//  OpcionesViewController.swift
//  HuacaBrava
//
//  Created by Christian  on 15/08/1402 AP.
//

import UIKit

class OpcionesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
