//
//  AdminBebidaViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 30/09/23.
//

import UIKit

class AdminBebidaViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var adminBebidaTableView: UITableView!
    
    var adminBebidaList: [AdminBebida] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminBebidaTableView.dataSource = self
        
        adminBebidaList.append(AdminBebida(nombre: "Coca Cola 1.5L", descripcion: "Bebida gaseosa", precio: "S/ 5.90", stock: "30", foto: (UIImage(named: "coca_cola"))))
        adminBebidaList.append(AdminBebida(nombre: "Fanta 3L", descripcion: "Bebida gaseosa sabor naranja", precio: "S/ 7.90", stock: "24", foto: (UIImage(named: "fanta_3l"))))

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return adminBebidaList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemAdminBebida", for: indexPath) as! AdminBebidaTableViewCell
            
            let adminBebida = adminBebidaList[indexPath.row]
            
            cell.nombreAdminBebidaLabel.text = adminBebida.nombre
            cell.descripcionAdminBebidaLabel.text = adminBebida.descripcion
            cell.precioAdminBebidaLabel.text = adminBebida.precio
            cell.stockAdminBebidaLabel.text = adminBebida.stock
            cell.fotoAdminBebidaImageView.image = adminBebida.foto
            
            return cell
        }

    
}
