//
//  StoryboardNavigableManager.swift
//  TabbarProject
//
//  Created by beyyzgur on 8.12.2025.
//

import UIKit

class StoryboardNavigableManager {
    static let shared = StoryboardNavigableManager()
    
    private init() {}
    
    let items: [StoryboardNavigable] = [
        HomeNavigable()
    ]
    
    func push(storyboardId: StoryboardIdentifier,
               navigationController: UINavigationController,
               delegate: AnyObject?,
               args: Any?,
               animated: Bool) {
        guard let item = items.first(where: {
            $0.isSatisfied(storyboardId: storyboardId, delegate: delegate, args: args) })
             else { return }
        
        DispatchQueue.main.async {
            item.execute(navigationController: navigationController, delegate: delegate, args: args)
        }
    }
}
