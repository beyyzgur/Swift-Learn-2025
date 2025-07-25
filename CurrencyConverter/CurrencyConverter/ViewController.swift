//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by beyyzgur on 25.07.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: UIButton) {
        fetchData()
    }
    
    func fetchData() { /// From API
        /// 1) Request & Session - istek yolla
        /// 2) Response & Data al - datayı al
        /// 3) Parsing & JSON Serialization - Aldığın veriyi PARSE et - datayı işle
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=5b6f277741a2b7e621e48b08d3bc6218")
        let session = URLSession.shared // shared diyerek singleton obje oluşturuyoruz, app içerisinde her yerden buna ulaşabiliriz
        let task = session.dataTask(with: url!) { (data, response, error) in // closure
            guard error == nil else {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true)
                return
            }
            if data != nil {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> // keyler hep string, karşısındakiler değişken
                    DispatchQueue.main.async {
                        if let rates = jsonResponse["rates"] as? [String : Any] {
                            
                            if let cad = rates["CAD"], let chf = rates["CHF"], let gbp = rates["GBP"], let jpy = rates["JPY"], let usd = rates["USD"], let turkishLira = rates["TRY"] {
                                self.cadLabel.text = "CAD: \(cad)"
                                self.chfLabel.text = "CHF: \(chf)"
                                self.gbpLabel.text = "GBP: \(gbp)"
                                self.jpyLabel.text = "JPY: \(jpy)"
                                self.usdLabel.text = "USD: \(usd)"
                                self.tryLabel.text = "TRY: \(turkishLira)"
                            }
                            
                        }
                    }
                } catch {
                    print("veri alındı, nil değil fakat okunamadı")
                }
            }
        }
        
        task.resume()
    }
}

