//
//  ViewController.swift
//  SimpsonBook
//
//  Created by beyyzgur on 18.07.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var SimpsonArray = [SimpsonModel]()
    var chosenSimpson: SimpsonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let homer = SimpsonModel(name: "Homer Simpson", job: "Nuclear Safety Engineer", image: UIImage(named: "Homer_Simpson")!)
        let marge = SimpsonModel(name: "Marge Simpson", job: "House wife", image: UIImage(named: "Marge_Simpson")!)
        let bart = SimpsonModel(name: "Bart Simpson", job: "Student", image: UIImage(named: "Bart_Simpson")!)
        let lisa = SimpsonModel(name: "Lisa Simpson", job: "Student", image: UIImage(named: "Lisa_Simpson")!)
        let maggie = SimpsonModel(name: "Maggie Simpson", job: "Baby", image: UIImage(named: "Maggie_Simpson")!)
        
        SimpsonArray.append(homer)
        SimpsonArray.append(marge)
        SimpsonArray.append(bart)
        SimpsonArray.append(lisa)
        SimpsonArray.append(maggie)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SimpsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = SimpsonArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = SimpsonArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil) // Detay sayfasına gönderen kod
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // segue ye hazırlan methodu
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
}

