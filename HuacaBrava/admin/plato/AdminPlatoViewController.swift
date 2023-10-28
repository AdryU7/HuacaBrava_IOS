//
//  AdminPlatoViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 27/09/23.
//

import UIKit

class AdminPlatoViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var adminPlatoTableView: UITableView!
    
    var adminPlatoList: [AdminPlato] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminPlatoTableView.dataSource = self
        
        adminPlatoList.append(AdminPlato(nombre: "Pollo a la parrilla", descripcion: "1/4 de pollo, papas fritas, ensalada", precio: "S/ 29.90", stock: "13", foto:"pollo_a_la_parrilla"))
        adminPlatoList.append(AdminPlato(nombre: "Pollo a la brasa", descripcion: "1/4 de pollo, papas fritas, ensalada con mayonesa, nuggets fritos", precio: "S/ 32.50", stock: "18", foto:"pollo_a_la_brasa"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminPlatoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemAdminPlato", for: indexPath) as! AdminPlatoTableViewCell
        
        let adminPlato = adminPlatoList[indexPath.row]
        
        cell.nombreAdminPlatoLabel.text = adminPlato.nombre
        cell.descripcionAdminPlatoLabel.text = adminPlato.descripcion
        cell.precioAdminPlatoLabel.text = adminPlato.precio
        cell.stockAdminPlatoLabel.text = adminPlato.stock
        cell.fotoAdminPlatoImageView.image = UIImage(named:adminPlato.foto)
        return cell
    }

}
