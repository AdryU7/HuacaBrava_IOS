//
//  CartaAltViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 18/10/23.
//

import UIKit
import Firebase

struct PlatoFirebase {
    var nombre: String
    var precio: String
}

struct CategoriasFirebase {
    var categoria: String // bebidas -- entradas
    var plato: [PlatoFirebase]
}

class CartaAltViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var cartaAltTableView: UITableView!
    
    var cartas: [CategoriasFirebase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCarta()
        
        cartaAltTableView.dataSource = self
        cartaAltTableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cartas.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let carta = cartas[section]
        return carta.categoria
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  cartas[section].plato.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCarta", for: indexPath) as! CartaAltTableViewCell
        
        let plato = cartas[indexPath.section].plato[indexPath.row]
        
        cell.tituloLabel?.text = plato.nombre
        cell.precioLabel?.text = plato.precio
        return cell
    }
        
   
}

extension CartaAltViewController {
    
    func listCarta() {
        let db = Firestore.firestore()
        db.collection("cartas").getDocuments(completion: { (query, error) in
            if let e = error {
                print(e)
            } else {
                if let q = query {
                    for document in q.documents {
                        let data = document.data()
                        
                        let bedidas = data["bebidas"] as? [[String: Any]] ?? []
                        var platosFirebase: [PlatoFirebase] = []
                        for map in bedidas {
                            let precio = map["precio"] as? String
                            let nombre = map["nombre"] as? String
                            let plato = PlatoFirebase(nombre: nombre ?? "", precio: precio ?? "")
                            platosFirebase.append(plato)
                        }
                        let categoriaBedidas = CategoriasFirebase(categoria: "Bebidas", plato: platosFirebase)
                        self.cartas.append(categoriaBedidas)
                        
                        let entradas = data["entradas"] as? [[String: Any]] ?? []
                        let catEntradas = self.mapeo(mapList: entradas, categoria: "Entradas")
                        self.cartas.append(catEntradas)
                        
                        let platos = data["platos"] as? [[String: Any]] ?? []
                        let catplatos = self.mapeo(mapList: platos, categoria: "Platos")
                        self.cartas.append(catplatos)
                        
                        let adicionales = data["adicionales"] as? [[String: Any]] ?? []
                        let catadicionales = self.mapeo(mapList: adicionales, categoria: "Adicionales")
                        self.cartas.append(catadicionales)
                        
                        let postres = data["postres"] as? [[String: Any]] ?? []
                        let catpostres = self.mapeo(mapList: postres, categoria: "Postres")
                        self.cartas.append(catpostres)
                    }
                    self.cartaAltTableView.reloadData()
                }
            }
        })
    }
    
    func mapeo(mapList: [[String: Any]], categoria: String) -> CategoriasFirebase {
        var platosFirebase: [PlatoFirebase] = []
        for map in mapList {
            let precio = map["precio"] as? String
            let nombre = map["nombre"] as? String
            let plato = PlatoFirebase(nombre: nombre ?? "", precio: precio ?? "")
            platosFirebase.append(plato)
        }
        return CategoriasFirebase(categoria: categoria, plato: platosFirebase)
    }
    
}
