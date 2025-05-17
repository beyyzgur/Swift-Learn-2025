//
//  ViewController.swift
//  TimerProject
//
//  Created by beyyzgur on 17.05.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        timeLabel.text = "Time : \(counter)"

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeLabel.text = "Time : \(counter)"
        counter -= 1
        
        if counter < 0 {
            timer.invalidate()
            timeLabel.text = "Time's Up!"
        }
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        print("button clicked")
    }
}
