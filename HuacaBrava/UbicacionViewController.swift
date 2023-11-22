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
        
        let pointTrujillo = CLLocationCoordinate2D(latitude: -8.1116778, longitude: -79.0287742)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Trujillo"
        annotation.subtitle = "Cuidad del Tiburon"
        annotation.coordinate = pointTrujillo
        
        mapaMapView.addAnnotation(annotation)
        
        let mapaCamera = MKMapCamera(lookingAtCenter: pointTrujillo, fromEyeCoordinate: pointTrujillo, eyeAltitude: 2000.0)
        mapaMapView.setCamera(mapaCamera, animated: true)
    }

}
