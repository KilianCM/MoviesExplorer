//
//  TheatreMapViewController.swift
//  MoviesExplorer
//
//  Created by Kilian Chamiot-Maitral on 10/03/2020.
//  Copyright © 2020 Kilian Chamiot-Maitral. All rights reserved.
//

import UIKit
import MapKit

class TheatreMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager = CLLocationManager()
    private var mapItems: [MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = MKPointOfInterestFilter(excluding: [.movieTheater])
        zoomOnUserLocation()
        loadPointOfInterest { mapItems in
            self.mapItems = mapItems
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
    
    private func zoomOnUserLocation() {
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
    
    private func loadPointOfInterest(completion: @escaping (([MKMapItem]) -> Void)) {
        let request = MKLocalSearch.Request()
        request.resultTypes = MKLocalSearch.ResultType.pointOfInterest
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.movieTheater, .theater])
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
    
    private func displayActionSheet(url: String?) {
        guard let urlAsString = url, let url = URL(string: urlAsString) else {
            return
        }
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Ouvrir le site web", style: .default, handler: { (UIAlertAction) in
            UIApplication.shared.open(url)
        })
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
            
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
            
        self.present(optionMenu, animated: true, completion: nil)
    }
}

extension TheatreMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let url = view.annotation?.subtitle {
            displayActionSheet(url: url)
        }
    }

    func showAnnotationDisclosure(sender: AnyObject) {
        print("Disclosure button clicked")
    }
}
