//
//  UbicacionViewController.swift
//  HuacaBrava
//
//  Created by DAMII on 18/10/23.
//

import UIKit
import MapKit

class UbicacionViewController: UIViewController {

    @IBOutlet weak var mapaMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapaMapView.overrideUserInterfaceStyle = .light
        
        let pointTrujillo = CLLocationCoordinate2D(latitude: -8.099970, longitude: -79.025810)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Restaurante Huaca Brava"
        annotation.subtitle = "El mejor lugar"
        annotation.coordinate = pointTrujillo
        
        mapaMapView.addAnnotation(annotation)
        
        let mapaCamera = MKMapCamera(lookingAtCenter: pointTrujillo, fromEyeCoordinate: pointTrujillo, eyeAltitude: 2000.0)
        mapaMapView.setCamera(mapaCamera, animated: true)
    }

}
