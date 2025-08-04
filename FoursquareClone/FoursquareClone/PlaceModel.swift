//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by beyyzgur on 31.07.2025.
//

import Foundation
import UIKit

class PlaceModel {
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage: UIImage?
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init() {}
    
}
