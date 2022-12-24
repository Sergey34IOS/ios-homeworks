//
//  AppDelegate.swift
//  Navigation
//
//  Created by My Air on 21.12.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarController = UITabBarController()
        let feedNavigationController = UINavigationController(rootViewController: FeedViewController())
        let profileNavigationController = UINavigationController(rootViewController: ProfileViewController())
        
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .green
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        
        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента",image: UIImage(systemName: "keyboard"), tag: 1)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
}
