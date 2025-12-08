//
//  StoryboardNavigable.swift
//  TabbarProject
//
//  Created by beyyzgur on 8.12.2025.
//

import UIKit

protocol StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool
    
    func execute(navigationController: UINavigationController, // optional olmali mi ? 
                 delegate: AnyObject?,
                 args: Any?)
}
