//
//  ProfileNavigable.swift
//  TestProject
//
//  Created by beyyzgur on 3.12.2025.
//

import UIKit.UIWindow

class ProfileNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .profile
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let storyboard = UIStoryboard(name: StoryboardName.profile.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: StoryboardIdentifier.profile.rawValue) as? ProfileViewController
           else { return }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
