//
//  CreditosViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 14/10/23.
//

import UIKit

class CreditosViewController: UIViewController {

    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var historialMovimientosView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        balanceView.layer.cornerRadius = 10
        balanceView.layer.masksToBounds = true
        
        historialMovimientosView.layer.cornerRadius = 10
        historialMovimientosView.layer.masksToBounds = true
    }
}
