//
//  PedidoViewController.swift
//  HuacaBrava
//
//  Created by Amalia Velasquez Elizalde on 28/11/23.
//

import UIKit
import CoreData

struct PedidoDetalle {
    var uidUsuario: String
    var carrito: [CarritoEntity]
    var direccion: String
    var montoTotal: Double
    var propina: Double
    var subTotal: Double
}

class PedidoViewController: UIViewController {

    var carritoList: [CarritoEntity] = []
    
    @IBOutlet weak var direccionEntregaTextField: UITextField!
    @IBOutlet weak var propinaRepartidorTextField: UITextField!
    @IBOutlet weak var costoTotalLabel: UILabel!
    @IBOutlet weak var costoServicioLabel: UILabel!
    @IBOutlet weak var costoEnvioLabel: UILabel!
    @IBOutlet weak var propinaRepartidorLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var propinaFinal: Double = 0
    var subTotalFinal: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalle Pedido"
        self.listCoreData()
        
        propinaRepartidorTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let value = textField.text else {
            propinaFinal = 0
            propinaRepartidorLabel.text = "S/ 0.00"
            return
        }
        guard let myDouble = Double(value) else {
            propinaFinal = 0
            propinaRepartidorLabel.text = "S/ 0.00"
            return
        }
        propinaFinal = myDouble
        propinaRepartidorLabel.text = "S/ \(String(format: "%.2f", myDouble))"
        
        self.sumarTotal()
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        self.openAlert(titulo: "Aviso", mensaje: "¿Está seguro que desea cancelar el pedido?")
    }
    
    func openAlert(titulo: String, mensaje: String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let action = UIAlertAction(title: "Sí, cancelar", style: .destructive) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "No, continuar", style: .default))
        self.present(alert, animated: true)
    }
    
    func sumarTotal() {
        let total = propinaFinal + subTotalFinal + 5 + 10
        totalLabel.text = "S/ \(String(format: "%.2f", total))"
    }
    
    @IBAction func realizarPedido(_ sender: Any) {
        self.removeCoreData()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "SucessViewController") as! SucessViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension PedidoViewController {
    
    func listCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextCoreData = appDelegate.persistentContainer.viewContext
        
        do {
            let result = try contextCoreData.fetch(CarritoEntity.fetchRequest()) as! [CarritoEntity]
            carritoList = result
            
            let subTotal = carritoList.reduce(0.0) { $0 + $1.precio * Double($1.cantidad) }
            subTotalFinal = subTotal
            
            costoTotalLabel.text = "S/ \(String(format: "%.2f", subTotal))"
            costoServicioLabel.text = "S/ 5.00"
            costoEnvioLabel.text = "S/ 10.00"
            
            self.sumarTotal()
            
        } catch let error as NSError {
            print("Se presentó un error al recuperar datos: \(error.localizedDescription)")
        }
        
    }
    
    func removeCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contextCoreData = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CarritoEntity")

        do {
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try contextCoreData.execute(batchDeleteRequest)
            try contextCoreData.save()
            
        } catch let error as NSError {
            print("Se presentó un error al recuperar datos: \(error.localizedDescription)")
        }
    }
    
}
