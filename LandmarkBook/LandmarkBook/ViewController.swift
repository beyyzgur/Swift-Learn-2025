//
//  ViewController.swift
//  LandmarkBook
//
//  Created by beyyzgur on 17.07.2025.
// uzun bir aradan sonra ContentView 'dan ViewController 'a geçiş - switching from ContentView to ViewController after a long time break (2 months :D)
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    
    var chosenLandmarkNames = ""
    var chosenLandmarkImages = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        landmarkNames.append("Anıtkabir 🇹🇷")
        landmarkNames.append("Colosseum")
        landmarkNames.append("Eiffel Tower")
        landmarkNames.append("Great Wall")
        landmarkNames.append("Kremlin")
        landmarkNames.append("Stonehenge")
        landmarkNames.append("Taj Mahal")
        
        landmarkImages.append(UIImage(named: "anitkabir")!)
        landmarkImages.append(UIImage(named: "colosseum")!)
        landmarkImages.append(UIImage(named: "eiffel-tower")!)
        landmarkImages.append(UIImage(named: "greatwall")!)
        landmarkImages.append(UIImage(named: "kremlin")!)
        landmarkImages.append(UIImage(named: "stonehenge")!)
        landmarkImages.append(UIImage(named: "taj-mahal")!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //cell.textLabel?.text = "row"
        var content = cell.defaultContentConfiguration()
        content.text = landmarkNames[indexPath.row]
        cell.contentConfiguration = content //(bunu anlamadım)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandmarkNames = landmarkNames[indexPath.row]
        chosenLandmarkImages = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as! DetailViewController
            destination.selectedLandmarkName = chosenLandmarkNames
            destination.selectedLandmarkImage = chosenLandmarkImages
          //destination.imageView.image = chosenLandmarkImages // bu uygulamayı çökertir, kod çalışsa da daha details VC oluşmadığı ve view did load çalışmadığı için bu uygulamayı çökertir & view did load çalışmadan - görünümler yüklenmeden çağırdığımız için app çöker. Ancak yukarıdaki sekilde chosen diyerek değişken oluşturarak yaparsan sıkıntı çıkmaz.
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            landmarkNames.remove(at: indexPath.row)
            landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

