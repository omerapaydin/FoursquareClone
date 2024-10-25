//
//  ShowController.swift
//  FoursquareClone
//
//  Created by Ömer on 25.10.2024.
//

import UIKit
import MapKit
import ParseCore

class ShowVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeAt: UILabel!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var chosenPlaceId = ""
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        getData()
        
        
    }
    
    
    func getData() {
        let query = PFQuery(className: "Places")
        
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            
            if error != nil {
                
            }else {
                
                
                if objects != nil {
                   let place = objects![0]
                    
                    if let placeNames = place.object(forKey: "name") as? String {
                        self.placeName.text = placeNames
                    }
                    if let placeTypes = place.object(forKey: "type") as? String {
                        self.placeType.text = placeTypes
                    }
                    if let placeAts = place.object(forKey: "atmosphere") as? String {
                        self.placeAt.text = placeAts
                    }
                    
                    if let lati = place.object(forKey: "latitude") as? String {
                        if let placeLatitude = Double(lati) {
                            self.chosenLatitude = placeLatitude
                        }
                    }
                    
                    if let long = place.object(forKey: "latitude") as? String {
                        if let placeLongitude = Double(long) {
                            self.chosenLongitude = placeLongitude
                        }
                    }
                    
                    
                    if let imageData = place.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { (data, error) in
                            if error == nil {
                                if data != nil {
                                    self.imageView.image = UIImage(data: data!)
                                }
                            }
                        }
                        
                        
                        
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.mapView.setRegion(region, animated: true)
                        
                        
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.placeName.text
                        annotation.subtitle = self.placeType.text
                        self.mapView.addAnnotation(annotation)
                        
                        
                        
                    }

                    
                    
                }
                
                
                
            }
            
            
        }
        
        
    }
    


}
