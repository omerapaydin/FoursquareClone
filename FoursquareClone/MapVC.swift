//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Ömer on 25.10.2024.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

   
    @IBOutlet weak var mapView: MKMapView!
    
    
    var locationManager = CLLocationManager()
    var chosenLatitude = ""
    var chosenLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .done, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognizer))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
        
        
        
    }
    
    
    @objc func longPressGestureRecognizer(_ recognizer: UILongPressGestureRecognizer) {
        
        if recognizer.state == .began {
            
            let touches = recognizer.location(in: self.mapView)
            let coordinate = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            self.mapView.addAnnotation(annotation)
            
            self.chosenLatitude = String(coordinate.latitude)
            self.chosenLongitude = String(coordinate.longitude)
           
            
        }
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
    }
    
    
    @objc func saveButtonClicked() {
        
    }
    
    
    @objc func backButtonClicked() {
        
    }
    
    
    

 

}
