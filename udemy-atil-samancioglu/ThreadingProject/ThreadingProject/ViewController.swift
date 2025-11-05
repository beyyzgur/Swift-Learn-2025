//
//  ViewController.swift
//  ThreadingProject
//
//  Created by beyyzgur on 28.08.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    let urlStrings = ["https://images.pexels.com/photos/3774243/pexels-photo-3774243.jpeg?cs=srgb&dl=pexels-souvenirpixels-3774243.jpg&fm=jpg", "https://images.pexels.com/photos/1054666/pexels-photo-1054666.jpeg?cs=srgb&dl=pexels-hsapir-1054666.jpg&fm=jpg"]
    var data = Data()
    var tracker = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegatesandDataSources()
        changeImage()
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(worstWayOfDownloadPicture))
    }
    
    @objc func worstWayOfDownloadPicture() {
         if tracker == 0 {
             tracker = 1
         } else {
             tracker = 0
         }
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!)
        }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: self.data)
        }
     }

    func setDelegatesandDataSources() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func changeImage() {
        DispatchQueue.global().async { // background thread
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!)
            DispatchQueue.main.async { // main thread
                self.imageView.image = UIImage(data: self.data)
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "threading test"
        return cell
    }
}
