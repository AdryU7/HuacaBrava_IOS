//
//  DetalleProductoViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 25/11/23.
//

import UIKit
import Firebase
import CoreData

class DetalleProductoViewController: UIViewController {

    @IBOutlet weak var fotoDetProdImageView: UIImageView!
    @IBOutlet weak var nombreDetProdLabel: UILabel!
    @IBOutlet weak var descripcionDetProdLabel: UILabel!
    @IBOutlet weak var precioActualDetProdLabel: UILabel!
    @IBOutlet weak var precioAnteriorDetProdLabel: UILabel!
    @IBOutlet weak var stockDetProdLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var cantidadDetProdLabel: UILabel!
    @IBOutlet weak var agregarAlCarritoButton: UIButton!
    
    var producto: Productos?
    var carritoItem: CarritoEntity = CarritoEntity()
    var carritoList: [CarritoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = producto {
            if let url_img = URL(string: product.foto) {
                fotoDetProdImageView.load(url: url_img)
            }
            nombreDetProdLabel.text = product.nombre
            descripcionDetProdLabel.text = product.descripcion
            precioActualDetProdLabel.text = "S/ \(String(format: "%.2f", product.precio_actual))"
            if (product.precio_anterior == 0) {
                precioAnteriorDetProdLabel.removeFromSuperview()
            }
            let precioAnterior = "S/ \(String(format: "%.2f", product.precio_anterior))"
            let attributeString = NSMutableAttributedString(string: precioAnterior)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            precioAnteriorDetProdLabel.attributedText = attributeString
            stockDetProdLabel.text = "Stock: \(product.stock)"
        }
        
        self.configurarEstadoButton()
        stepper.minimumValue = 1
        stepper.value = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        cantidadDetProdLabel.text = Int(sender.value).description
        self.configurarEstadoButton()
    }
    
    func configurarEstadoButton() {
        guard let stock = producto?.stock else {
            return
        }
        
        if stock == 0 {
            cambiarEstadoButton(agotado: true)
            stepper.isEnabled = false
            cantidadDetProdLabel.removeFromSuperview()
        } else {
            cambiarEstadoButton(agotado: false)
        }
    }
    
    func cambiarEstadoButton(agotado: Bool) {
        if agotado {
            agregarAlCarritoButton.setTitle("Agotado", for: .normal)
            agregarAlCarritoButton.backgroundColor = .systemGray5
            agregarAlCarritoButton.layer.cornerRadius = 5
            agregarAlCarritoButton.isEnabled = false
        } else {
            agregarAlCarritoButton.setTitle("Agregar al carrito", for: .normal)
            agregarAlCarritoButton.backgroundColor = .systemBlue
            agregarAlCarritoButton.layer.cornerRadius = 5
            agregarAlCarritoButton.isEnabled = true
        }
    }
    
    @IBAction func agregarAlCarrito(_ sender: UIButton) {
        guard let product = producto,
              let cantidadString = cantidadDetProdLabel.text,
              let cantidad = Int(cantidadString) else {
            return
        }
        
        if carritoList.contains(where: { $0.nombre == product.nombre }) {
            let alert = UIAlertController(title: "Producto duplicado", message: "Este producto ya está en tu carrito.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            if cantidad > product.stock {
                showAlert(titulo: "ERROR", mensaje: "La cantidad ingresada no debe exceder al stock disponible.")
            } else {
                self.agregarItem(nombre: product.nombre, precio: (product.precio_actual * Double(cantidad)), cantidad: cantidad)
            }
        }
    }
    
    func showAlert(titulo: String, mensaje: String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let button = UIAlertAction(title: "Entendido", style:.default)
        alert.addAction(button)
        self.present(alert, animated: true)
    }
    
}

extension DetalleProductoViewController {
    func agregarItem(nombre: String, precio: Double, cantidad: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let nuevoProducto = CarritoEntity(context: context)
        nuevoProducto.nombre = nombre
        nuevoProducto.precio = precio
        nuevoProducto.cantidad = Int32(cantidad)
        
        do {
            try context.save()
            self.showAlert(titulo: "Aviso", mensaje: "Producto guardado en el carrito exitosamente.")
        } catch let error as NSError {
            self.showAlert(titulo: "Error", mensaje: "Se ha producido un error al guardar, vuelva a intentarlo más tarde.")
            print(error)
        }
    }
}
