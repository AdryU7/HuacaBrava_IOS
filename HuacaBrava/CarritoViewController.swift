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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carritoTableView.dataSource = self
        carritoTableView.delegate = self
        listCoreData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carritoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCarrito", for: indexPath) as! CarritoTableViewCell
        let carrito = carritoList[indexPath.row]
        cell.nombreCarritoLabel.text = carrito.nombre
        cell.fotoCarritoImageView.image = UIImage(named: carrito.foto!)
        cell.precioCarritoLabel.text = carrito.precio
        cell.stockCarritoLabel.text = carrito.stock
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Eliminar",
                                              handler: { _,_, complete in
            let item = self.carritoList[indexPath.row]
            self.deleteCoreData(carrito: item)
            self.carritoList.remove(at: indexPath.row)
            self.carritoTableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
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
        
        let entity = CarritoEntity(context: contextCoreData)
        
        do {
            let result = try contextCoreData.fetch(CarritoEntity.fetchRequest())
            carritoList = result
        } catch let error as NSError {
            print("Se presento un error")
        }
        carritoTableView.reloadData()
    }
    
    func deleteCoreData(carrito: CarritoEntity) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextCoreData = appDelegate.persistentContainer.viewContext
        
        contextCoreData.delete(carrito)
        do {
            try contextCoreData.save()
        } catch let error as NSError {
            print("Se presento un error")
        }
        carritoTableView.reloadData()
    }
}
