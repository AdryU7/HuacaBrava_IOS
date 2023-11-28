//
//  CarritoViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 11/10/23.
//

import UIKit
import CoreData

class CarritoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var carritoList: [CarritoEntity] = []
    
    @IBOutlet weak var carritoTableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carritoTableView.dataSource = self
        carritoTableView.delegate = self
        listCoreData()
        actualizarSubtotal()
    }
    
    func actualizarSubtotal() {
        let subtotal = calcularSubtotal()
        subtotalLabel.text = "Subtotal: S/ \(String(format: "%.2f", subtotal))"
    }
    
    func calcularSubtotal() -> Double {
        return carritoList.reduce(0.0) { $0 + $1.precio * Double($1.cantidad) }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carritoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCarrito", for: indexPath) as! CarritoTableViewCell
        let carrito = carritoList[indexPath.row]
        cell.nombreCarritoLabel.text = carrito.nombre
        cell.precioCarritoLabel.text = "S/ \(String(format: "%.2f", carrito.precio))"
        cell.cantidadCarritoLabel.text = "\(carrito.cantidad)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Eliminar",
                                              handler: { _,_, complete in
            let alert = UIAlertController(title: "Aviso", message: "¿Está seguro que desea eliminar este producto del carrito?", preferredStyle: .alert)
            let button = UIAlertAction(title: "Sí, eliminar", style:.destructive) { action in
                let item = self.carritoList[indexPath.row]
                self.deleteCoreData(carrito: item)
                self.carritoList.remove(at: indexPath.row)
                self.carritoTableView.deleteRows(at: [indexPath], with: .automatic)
                complete(true)
            }
            let cancel = UIAlertAction(title: "No, cancelar", style: .cancel)
            alert.addAction(button)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        })
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension CarritoViewController {
    func listCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextCoreData = appDelegate.persistentContainer.viewContext
        
        do {
            let result = try contextCoreData.fetch(CarritoEntity.fetchRequest()) as! [CarritoEntity]
            carritoList = result
        } catch let error as NSError {
            print("Se presentó un error al recuperar datos: \(error.localizedDescription)")
        }
        carritoTableView.reloadData()
    }
    
    func deleteCoreData(carrito: CarritoEntity) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextCoreData = appDelegate.persistentContainer.viewContext
        
        contextCoreData.delete(carrito)
        do {
            try contextCoreData.save()
            actualizarSubtotal()
        } catch let error as NSError {
            print("Se presento un error: \(error)")
        }
        carritoTableView.reloadData()
    }
}
