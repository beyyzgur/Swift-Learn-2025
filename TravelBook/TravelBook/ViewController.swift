//
//  ViewController.swift
//  TravelBook
//
//  Created by beyyzgur on 23.07.2025.
//


import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    var selectedTitle = ""
    var selectedID: UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // Konum devamlı takip edilmiyor, yalnızca app içerisinde takip ediliyor.
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if selectedTitle != "" {
            //CoreData 'dan veri çekilecek
            
            getDataFromCoreData()
            locationManager.stopUpdatingLocation()
            
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func getDataFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        let idString = selectedID!.uuidString
        request.predicate = NSPredicate(format: "id = %@", idString) //belleğe id si idStringe eşit olan idleri getir /// burada neden arg kısmı string istiyo ??
        request.returnsObjectsAsFaults = false
        
        do {
           let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let title = result.value(forKey: "title") as? String {
                        annotationTitle = title
                        
                        if let subtitle = result.value(forKey: "subtitle") as? String {
                            annotationSubtitle = subtitle
                            
                            if let latitude = result.value(forKey: "latitude") as? Double {
                                annotationLatitude = latitude
                                
                                if let longitude = result.value(forKey: "longitude") as? Double {
                                    annotationLongitude = longitude
                                    
                                    let annotation = MKPointAnnotation()
                                    annotation.title = annotationTitle
                                    annotation.subtitle = annotationSubtitle
                                    let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                    annotation.coordinate = coordinate
                                    
                                    mapView.addAnnotation(annotation)
                                    nameTextField.text = annotationTitle
                                    commentTextField.text = annotationSubtitle
                                    
                                    locationManager.stopUpdatingLocation()
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    let region = MKCoordinateRegion(center: coordinate , span: span)
                                    mapView.setRegion(region, animated: true)
                                }
                                
                            }
                            
                        }
                        
                    }
                }
            }
            
        } catch {
            print("ERROR: request fetch edilemedi - ViewController")
        }
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinate = mapView.convert(touchedPoint, toCoordinateFrom: mapView)
            
            chosenLatitude = touchedCoordinate.latitude
            chosenLongitude = touchedCoordinate.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinate
            annotation.title = nameTextField.text
            annotation.subtitle = commentTextField.text
            self.mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        newPlace.setValue(nameTextField.text, forKey: "title")
        newPlace.setValue(commentTextField.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlace"), object: nil)
        navigationController?.popViewController(animated: true) // bi önceki controllera geri götürür
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { // kullanıcının anlık lokasyonunu pinle gösterir
            return nil
        }
        let reuseID = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as! MKMarkerAnnotationView?
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true // baloncukla bilgi gösterilen yer
            pinView?.tintColor = UIColor(.green)
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedTitle != "" {
            var requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                // closure - callback func verir
                
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let newPlaceMark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlaceMark)
                        item.name = self.annotationTitle // closure ın içinde self kullanman lazımm
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeKey]
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
                
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == "" {
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        } else {
            
        }
    }

}
/// mapte kendimi zoomlayamiyommmmm - optionla zoomlayabiliyormuşum 🌟
