//
//  HomeNavigable.swift
//  TabbarProject
//
//  Created by beyyzgur on 8.12.2025.
//

import UIKit

class HomeNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .home
    }
    
    func execute(navigationController: UINavigationController,
                 delegate: AnyObject?,
                 args: Any?) {
        let storyboard = UIStoryboard(name: StoryboardName.home.rawValue, bundle: nil)
        guard let homeViewController = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.home.rawValue) as? HomeViewController
        else { return }
        
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
