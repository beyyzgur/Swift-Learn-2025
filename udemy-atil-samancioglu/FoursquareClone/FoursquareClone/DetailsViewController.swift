//
//  DetailsViewController.swift
//  FoursquareClone
//
//  Created by beyyzgur on 31.07.2025.
//

import UIKit
import MapKit
import Parse

typealias DetailsViewControllerItems = AlertPresentable

final class DetailsViewController: UIViewController, DetailsViewControllerItems {
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var chosenID = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        getDataFromParse()
    }
    
    func setDelegates() {
        detailsMapView.delegate = self
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenID)
        query.findObjectsInBackground { (objects, error) in
            guard error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error while getting data from Parse")
                return
            }
            if objects != nil {
                let chosenPlaceObject = objects![0]
                
                //MARK: - OBJECTS
                
                if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                    self.detailsNameLabel.text = placeName
                }
                if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                    self.detailsTypeLabel.text = placeType
                }
                if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                    self.detailsAtmosphereLabel.text = placeAtmosphere
                }
                if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                    if let placeLatitudeDouble = Double(placeLatitude) {
                        self.chosenLatitude = placeLatitudeDouble
                    }
                }
                if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                    if let placeLongitudeDouble = Double(placeLongitude) {
                        self.chosenLongitude = placeLongitudeDouble
                    }
                }
                if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                    imageData.getDataInBackground { (data, error) in
                        guard error == nil else {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error downloading image")
                            return
                        }
                        if data != nil {
                            self.detailsImageView.image = UIImage(data: data!)
                        }
                    }
                }
                
                //MARK: - MAPS
                let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                let region = MKCoordinateRegion(center: location, span: span)
                self.detailsMapView.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.detailsNameLabel.text
                annotation.subtitle = self.detailsTypeLabel.text
                self.detailsMapView.addAnnotation(annotation)
                
            }
        }
    }

}

extension DetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "reuseId")
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "reuseId")
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.systemGreen
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLatitude != 0.0 && self.chosenLongitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        
                        mapItem.name = self.detailsNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
                
            }
        }
    }
}
