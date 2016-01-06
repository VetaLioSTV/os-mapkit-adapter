//
//  ViewController.swift
//  MapKitExampleSwift
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

import UIKit
import MapKit
import OSMapKitAdapter

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tileOverlay = OSTileOverlay(APIKey: "", product: .Zoom)
        mapView.addOverlay(tileOverlay)
        mapView.delegate = self
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 50.9386, longitude: -1.4705)
        mapView.region = MKCoordinateRegion(center: mapView.centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer(overlay: overlay)
        }

        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
}

