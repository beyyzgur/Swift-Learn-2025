//
//  DetailNavigable.swift
//  TestProject
//
//  Created by beyyzgur on 2.12.2025.
//

import UIKit.UIWindow

class DetailNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .detail
    }
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let storyboard = UIStoryboard(name: StoryboardName.detail.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: StoryboardIdentifier.detail.rawValue) as? DetailViewController
        else { return }
        
        // burada 2 yol var. yeni ekrani ya push edecegiz (soldan saga, navigation controller lazim)
        // 2. yol: yeni ekrani present etmek. (ya navigationController.present ile ya da gelen delegate'yi bir presenter gibi nesneye atip
        // as? UIViewController yaparak o delegate (presenter) uzerinden presenter.present yaparak yeni ekrani acabiliriz.
        
        //navigationController?.pushViewController(viewController, animated: true)
        //viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true)
    }
}
