//
//  InicioViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 18/10/23.
//

import UIKit

class InicioViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var productosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productosCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InicioCollectionViewCell", for: indexPath) as! InicioCollectionViewCell
        cell.productoImagenView.image = UIImage(named: "pollo_a_la_brasa")
        return cell
    }
    

}
