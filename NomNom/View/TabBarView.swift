//
//  TabBarVIew.swift
//  nomnom
//
//  Created by Jack on 11/9/23.
//

import UIKit

class TabBarView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTabViews()
    }
    
    private func loadTabViews() {
        
        let defaults = UserDefaults.standard
        let cardIDArray = defaults.stringArray(forKey: "CardIDArray") ?? [String]()
        
        let homeController = HomeController()
        let favController = FavController()
        favController.loadViewIfNeeded()
        
        //let navController = UINavigationController(rootViewController: myCollectionVC)
        //self.present(navController, animated: true, completion: nil)
        
        
        
        homeController.tabBarItem.image = UIImage(systemName: "person")
        let navController = UINavigationController(rootViewController: homeController)
        
        
        favController.title = "Favorite"
        favController.tabBarItem.image = UIImage(systemName: "star")
        let navControllerfav = UINavigationController(rootViewController: favController)
        
        
        
        self.setViewControllers([navController, navControllerfav], animated: false)
        self.tabBar.backgroundColor = .white
    }
}


