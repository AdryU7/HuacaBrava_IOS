//
//  AdminEmpleadoViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 27/09/23.
//

import UIKit

class AdminEmpleadoViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var adminEmpleadoTableView: UITableView!
    
    var adminEmpleadoList: [AdminEmpleado] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminEmpleadoTableView.dataSource = self
        
        adminEmpleadoList.append(AdminEmpleado(nombres: "Manuel", apellidos: "Sanchez Saavedra", dni: "88753857", ocupacion: "Mesero", fotoCarnet: (UIImage(named: "foto_carnet_1"))))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminEmpleadoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemAdminEmpleado", for: indexPath) as! AdminEmpleadoTableViewCell
        
        let adminEmpleado = adminEmpleadoList[indexPath.row]
        
        cell.nombresAdminEmpleadoLabel.text = adminEmpleado.nombres
        cell.apellidosAdminEmpleadoLabel.text = adminEmpleado.apellidos
        cell.dniAdminEmpleadoLabel.text = adminEmpleado.dni
        cell.ocupacionAdminEmpleadoLabel.text = adminEmpleado.ocupacion
        cell.fotoCarnetAdminEmpleadoImageView.image = adminEmpleado.fotoCarnet
        
        return cell
    }
    

}
