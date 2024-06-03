//
//  MainTabbarViewController.swift
//  NewsApplication
//
//  Created by Paul on 3/6/2567 BE.
//

import Foundation
import UIKit

class MainTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        setUpTabbar()
    }
    
    private func setUpTabbar() {
        let homepage = MainViewController(nibName: "Main", bundle: nil)
        homepage.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        let searchpage = SearchNewsViewController(nibName: "SearchNews", bundle: nil)
        searchpage.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let viewTabbars = [homepage, searchpage]
        self.setViewControllers(viewTabbars, animated: true)
        setUITabbar()
    }
    
    private func setUITabbar() {
        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = .white
    }
    
}
