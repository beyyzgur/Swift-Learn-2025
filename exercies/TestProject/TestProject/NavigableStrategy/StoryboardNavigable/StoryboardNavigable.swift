//
//  StoryboardNavigable.swift
//  TestProject
//
//  Created by beyyzgur on 2.12.2025.
//

import UIKit.UIWindow

protocol StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?)
}
