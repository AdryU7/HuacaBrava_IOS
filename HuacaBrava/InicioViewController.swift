//
//  InicioViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 18/10/23.
//

import UIKit
import Firebase

class InicioViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var productosCollectionView: UICollectionView!
    
    var productosList: [Productos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productosCollectionView.dataSource = self
        productosCollectionView.delegate = self
        self.listFiveProductosByAsc()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InicioCollectionViewCell", for: indexPath) as! InicioCollectionViewCell
        let productos = productosList[indexPath.row]
        if let url_img = URL(string: productos.foto) {
            cell.fotoProductoImageView.load(url: url_img)
        }
        cell.nombreProductoLabel.text = productos.nombre
        cell.precioActualProductoLabel.text = "S/ \(String(format: "%.2f", productos.precio_actual))"
        
        cell.fotoProductoImageView.layer.cornerRadius = 15
        cell.fotoProductoImageView.layer.masksToBounds = true
        cell.productoLayoutView.layer.cornerRadius = 10
        cell.productoLayoutView.layer.masksToBounds = true
        
        return cell
    }
}

extension InicioViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let cellWidth: CGFloat = 140 + 80
        //let cellHeight: CGFloat = 80 + 160
        return CGSize(width: 180, height: 200)
    }
}

extension InicioViewController {
    func listFiveProductosByAsc() {
        let db = Firestore.firestore()
        db.collection("productos")
            .order(by: "precio_actual", descending: false)
            .limit(to: 5)
            .getDocuments(completion: { (query, error) in
            if let e = error {
                print(e)
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
                    self.productosCollectionView.reloadData()
                }
            }
        })
    }
}
