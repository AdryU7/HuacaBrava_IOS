//
//  CartaViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 30/09/23.
//

import UIKit

class CartaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cartaTableView: UITableView!
    
    var cartaList: [Carta] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartaTableView.dataSource = self
        cartaTableView.delegate = self
        
        cartaList.append(Carta(foto: (UIImage(named: "menu_1"))))
        cartaList.append(Carta(foto: (UIImage(named: "menu_2"))))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCarta", for: indexPath) as! CartaTableViewCell
        
        let carta = cartaList[indexPath.row]
        
        cell.fotoCartaImageView.image = carta.foto
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cartaSecondViewController = storyboard?.instantiateViewController(withIdentifier: "ImageCarta") as! CartaSecondViewController
        let carta = cartaList[indexPath.row]
        cartaSecondViewController.imagen = carta.foto
        navigationController?.pushViewController(cartaSecondViewController, animated: true)
    }

}
