//
//  TheatreMapViewController.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 10/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit
import MapKit

class TheatreMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // show only movie theater on map
        mapView.pointOfInterestFilter = .some(MKPointOfInterestFilter(including: [MKPointOfInterestCategory.movieTheater]))

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 3000, longitudinalMeters: 3000)
            mapView.setRegion(viewRegion, animated: true)
        }

        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
}
