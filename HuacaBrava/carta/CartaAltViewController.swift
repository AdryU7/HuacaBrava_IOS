//
//  CartaAltViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 18/10/23.
//

import UIKit
import Firebase

struct CartaFirebase {
    let titulo: String
    let descripcion: String
}

class CartaAltViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var cartaAltTableView: UITableView!
    
    var cartas: [CartaAlt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartas = [
            CartaAlt(titulo: "Carta 1", descripcion: "Esta es la carta 1"),
            CartaAlt(titulo: "Carta 2", descripcion: "Esta es la carta 2")
        ]
        
        cartaAltTableView.dataSource = self
        cartaAltTableView.delegate = self
    }
    // DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartas.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCarta", for: indexPath) as! CartaAltTableViewCell
        let card = cartas[indexPath.row]
        cell.tituloLabel?.text = card.titulo
        cell.descripcionLabel?.text = card.descripcion
        return cell
    }
    // DELEGATE
    var isDetailViewControllerPresented = false
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*guard !isDetailViewControllerPresented else {
            return
        }
        
        isDetailViewControllerPresented = true
        
        let selectedCard = cartas[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: selectedCard)*/
        let selectedCard = cartas[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cartaDetalleViewController = storyboard.instantiateViewController(withIdentifier: "CartaDetalleViewController") as? CartaDetalleViewController {
            cartaDetalleViewController.carta = selectedCard
            self.present(cartaDetalleViewController, animated: true, completion: nil)
        }
    }
        
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let selectedCard = sender as? CartaAlt, let cartaDetalleViewController = segue.destination as? CartaDetalleViewController
        {
            cartaDetalleViewController.carta = selectedCard
        }
    }*/
}
