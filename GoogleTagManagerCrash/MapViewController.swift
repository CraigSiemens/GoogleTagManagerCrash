//
//  MapViewController.swift
//  GoogleTagManagerCrash
//
//  Created by Neo on 2022-03-01.
//

import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
    }
}
