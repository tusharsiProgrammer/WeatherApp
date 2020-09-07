//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Tushar Sonawane on 07/09/20.
//  Copyright © 2020 Tushar Sonawane. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationViewModel = LocationViewModel()
    
    var coordinate: Coord? {
        didSet {
            DispatchQueue.main.async {
                self.mapUpdateView()
            }
        }
    }
    
    var pushCoordinate: Coord? {
        didSet {
            DispatchQueue.main.async {
                self.pushToDetailView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        gestureRecognizer.delegate = self
        mapView.delegate = locationViewModel
        mapView.addGestureRecognizer(gestureRecognizer)
        
        locationViewModel.currentCoord = { [weak self] (data: Coord) in
            self?.coordinate = data
        }
        
        locationViewModel.pushWithCoord = { [weak self] (data: Coord) in
            self?.pushCoordinate = data
        }
        print("Latitude: \(coordinate)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func pushToDetailView() {
        let  mainView = UIStoryboard(name:"Main", bundle: nil)
        let viewcontroller = mainView.instantiateViewController(withIdentifier: "DetailMapViewController") as! DetailMapViewController
        viewcontroller.pushCoordinate = pushCoordinate
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    private func mapUpdateView() {
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(coordinate?.lat ?? 0.0, coordinate?.lon ?? 0.0);
        myAnnotation.title = "Current location"
        let center = CLLocationCoordinate2D(latitude: coordinate?.lat ?? 0.0, longitude: coordinate?.lon ?? 0.0)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(myAnnotation)
    }
    
}

extension MapViewController : UIGestureRecognizerDelegate {
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}
