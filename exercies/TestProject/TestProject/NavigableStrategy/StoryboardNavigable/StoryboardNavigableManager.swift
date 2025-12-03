//
//  StoryboardNavigableManager.swift
//  TestProject
//
//  Created by beyyzgur on 1.12.2025.
//

import UIKit.UIWindow

class StoryboardNavigableManager {
    static let shared = StoryboardNavigableManager()
    
    private init(){}
    
    private let items: [StoryboardNavigable] = [
        DetailNavigable(),
        ProfileNavigable()
    ]
    
    func push(navigationController: UINavigationController?,
              storyboardIdentifier: StoryboardIdentifier,
              delegate: AnyObject? = nil,
              args: Any? = nil,
              animated: Bool) {
        
        guard let navigable = items.first(where: {
            $0.isSatisfied(storyboardId: storyboardIdentifier, delegate: delegate, args: args)
        }) else { return }
        
        DispatchQueue.main.async {
            navigable.execute(navigationController: navigationController,
                              delegate: delegate,
                              args: args)
        }
    }
}
