//
//  ProductoViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 25/11/23.
//

import UIKit
import Firebase

class ProductoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var productosTableView: UITableView!
    
    var productosList: [Productos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productosTableView.dataSource = self
        self.productosTableView.delegate = self
        self.listProductos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemProducto", for: indexPath) as! ProductoTableViewCell
        let productos = productosList[indexPath.row]
        
        cell.nombreProdLabel.text = productos.nombre
        if (productos.precio_anterior == 0) {
            cell.precioAnteriorProdLabel.removeFromSuperview()
        }
        cell.precioAnteriorProdLabel.text = "S/ \(productos.precio_anterior)"
        cell.precioActualProdLabel.text = "S/ \(productos.precio_actual)"
        cell.stockProdLabel.text = "\(productos.stock)"
        // IMAGEN URL
        if let url_img = URL(string: productos.foto) {
            cell.fotoProdImageView.load(url: url_img)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = productosList[indexPath.row]
        if let detalleProductoVC = storyboard?.instantiateViewController(withIdentifier: "DetalleProductoViewController") as? DetalleProductoViewController {
            detalleProductoVC.producto = selectedProduct
            navigationController?.pushViewController(detalleProductoVC, animated: true)
        }
    }
}

extension ProductoViewController {
    func listProductos() {
        let db = Firestore.firestore()
        db.collection("productos").getDocuments(completion: { (query, error) in
            if let e = error {
                print("ERROR")
            } else {
                if let q = query {
                    for document in q.documents {
                        let data = document.data()
                        let foto = data["foto"] as? String ?? ""
                        let nombre = data["nombre"] as? String ?? ""
                        let descripcion = data["descripcion"] as? String ?? ""
                        let tipo = data["tipo"] as? String ?? ""
                        let precio_anterior = data["precio_anterior"] as? Double ?? 0
                        let precio_actual = data["precio_actual"] as? Double ?? 0
                        let stock = data["stock"] as? Int ?? 0
                        
                        let producto = Productos(foto: foto, nombre: nombre, descripcion: descripcion, tipo: tipo, precio_anterior: precio_anterior, precio_actual: precio_actual, stock: stock)
                        self.productosList.append(producto)
                    }
                    self.productosTableView.reloadData()
                }
            }
        })
    }
}
