//
//  PlatosDisponiblesViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 28/10/23.
//

import UIKit
import CoreData

class PlatosDisponiblesViewController: UIViewController, UITableViewDataSource {
    var platoList: [Plato] = []
    
    @IBOutlet weak var platosTableView: UITableView!
    
    var carritoItems: [CarritoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        platosTableView.dataSource = self
        
        platoList.append(Plato(nombre: "Pollo a la parrilla", stock: "13", precio: "S/ 29.90", foto: "pollo_a_la_parrilla"))
        platoList.append(Plato(nombre: "Pollo a la brasa", stock: "18", precio: "S/ 32.50", foto: "pollo_a_la_brasa"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemPlato", for: indexPath) as! PlatoTableViewCell
        
        let plato = platoList[indexPath.row]
        
        cell.nombreLabel.text = plato.nombre
        cell.precioLabel.text = plato.precio
        cell.stockLabel.text = plato.stock
        cell.fotoImageView.image = UIImage(named: plato.foto)
        
        // Agregar un botón para agregar al carrito en tu celda y conectarlo a un método
        cell.agregarAlCarritoButton.addTarget(self, action: #selector(agregarCarritoButton(_:)), for: .touchUpInside)
        cell.agregarAlCarritoButton.tag = indexPath.row
        return cell
    }
    
    @IBAction func agregarCarritoButton(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextCoreData = appDelegate.persistentContainer.viewContext
        let selectedPlato = platoList[sender.tag]
        
        // Verificar si el plato ya está en el carrito
        if !carritoItems.contains(where: { $0.nombre == selectedPlato.nombre }) {
            // Crear un objeto CarritoItem y configurar sus atributos con los datos seleccionados
            let carritoItem = CarritoEntity(context: contextCoreData)
            carritoItem.nombre = selectedPlato.nombre
            carritoItem.precio = selectedPlato.precio
            carritoItem.stock = selectedPlato.stock
            carritoItem.foto = selectedPlato.foto
            carritoItem.cantidad = 1
            
            print(carritoItems.append(carritoItem))
            
            do {
                try contextCoreData.save()
                showAlert(mensaje: "Cambios aplicados")
            } catch let error as NSError {
                print("Error al guardar en el carrito")
            }
        } else {
            showAlert(mensaje: "Este plato ya está en el carrito")
        }
        
        
        /* // Actualizar la vista del carrito después de agregar un elemento
        if let carritoViewController = self.tabBarController?.viewControllers?[1] as? CarritoViewController {
            carritoViewController.listCoreData()
        }*/
    }
    
    func showAlert(mensaje : String){
        let alert = UIAlertController(title: "Aviso", message: mensaje, preferredStyle: .alert)
        let button = UIAlertAction(title: "Entendido", style:.default)
        alert.addAction(button)
        self.present(alert, animated: true)
    }
}
