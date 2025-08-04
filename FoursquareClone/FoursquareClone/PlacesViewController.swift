//
//  PlacesViewController.swift
//  FoursquareClone
//
//  Created by beyyzgur on 31.07.2025.
//

import UIKit
import Parse

typealias PlacesViewControllerItems = AlertPresentable

final class PlacesViewController: UIViewController, PlacesViewControllerItems {
    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceId = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromParse()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.chosenID = selectedPlaceId
        }
    }
    
    //MARK: - @objc functions
    
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toOptionsVC", sender: nil)
    }
    
    @objc func logOutButtonClicked() {
        PFUser.logOutInBackground { error in
            guard error == nil else {
                self.makeAlert(title: "Error", message: "Could not logout")
                return
            }
            self.performSegue(withIdentifier: "toSignVC", sender: nil)
        }
    }
    
    func setNavBarItems() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.done, target: self, action: #selector(logOutButtonClicked))
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            guard error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error while getting data from parse - placesVC")
                return
            }
            if objects != nil {
                self.placeIdArray.removeAll(keepingCapacity: false)
                self.placeNameArray.removeAll(keepingCapacity: false)
                
                for object in objects! {
                    if let placeName = object.object(forKey: "name") as? String {
                        if let placeId = object.objectId {
                            self.placeIdArray.append(placeId)
                            self.placeNameArray.append(placeName)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource

extension PlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PlacesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}
