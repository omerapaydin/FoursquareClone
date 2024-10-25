//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Ömer on 25.10.2024.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){}
    
    
}
