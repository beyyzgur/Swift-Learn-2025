//
//  MainTabBarController.swift
//  TabbarProject
//
//  Created by beyyzgur on 8.12.2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let homeStoryboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
    let barcodeStoryboard = UIStoryboard(name: StoryboardName.barcode.rawValue, bundle: nil)
    let chatbotStoryboard = UIStoryboard(name: StoryboardName.chatbot.rawValue, bundle: nil)
    let profileStoryboard = UIStoryboard(name: StoryboardName.profile.rawValue, bundle: nil)
    
    
    func setUpController() {
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.home.rawValue)
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        
        let barcodeViewController = barcodeStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.barcode.rawValue)
        let barcodeNavControler = UINavigationController(rootViewController: barcodeViewController)
        
        let chatbotViewController = chatbotStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.chatbot.rawValue)
        let chatbotNavController = UINavigationController(rootViewController: chatbotViewController)
        
        let profileViewController = profileStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.profile.rawValue)
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        
        setViewControllers([
            homeNavController,
            barcodeNavControler,
            chatbotNavController,
            profileNavController
        ], animated: true)
    }
}
