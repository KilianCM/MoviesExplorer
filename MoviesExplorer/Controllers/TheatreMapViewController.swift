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
        mapView.pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.movieTheater])

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
        
        loadPointOfInterest { mapItems in
            let annotations = mapItems.compactMap { mapItem -> MKAnnotation? in
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                annotation.subtitle = mapItem.url?.absoluteString
                return annotation
            }
            DispatchQueue.main.async {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
    
    private func loadPointOfInterest(completion: @escaping (([MKMapItem]) -> Void)) {
        let request = MKLocalSearch.Request()
        request.resultTypes = MKLocalSearch.ResultType.pointOfInterest
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.movieTheater])
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            completion(response.mapItems)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        //TODO: handle click on annotation
    }
}
