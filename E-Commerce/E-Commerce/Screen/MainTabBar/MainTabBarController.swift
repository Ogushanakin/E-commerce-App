//
//  MainTabBarController.swift
//  E-Commerce
//
//  Created by Oğuzhan Akın on 27.07.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureTabBar()
        
    }
    
    private func setupTabBar() {
        let viewControllers = [homeController(), searchController(), cartController(), profileController()]
        setViewControllers(viewControllers, animated: true)
    }
    
    private func configureTabBar() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .black
    }
    
    private func homeController() -> UINavigationController {
        let homeVC = HomeController()
        homeVC.title = "E-Commerce"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "fi_9643115"), selectedImage: UIImage(named: "fi_9664027"))
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    private func searchController() -> UINavigationController {
        let searchVC = HomeController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search1"), selectedImage: UIImage(named: "search2"))
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func cartController() -> UINavigationController {
        let cartVC = CartController()
        cartVC.title = "Cart"
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cart1"), selectedImage: UIImage(named: "cart2" ))
        
        return UINavigationController(rootViewController: cartVC)
    }
    
    private func profileController() -> UINavigationController {
        let profileVC = ProfileController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person" ), selectedImage: UIImage(systemName: "person.fill"))
        
        return UINavigationController(rootViewController: profileVC)
    }
    
}
