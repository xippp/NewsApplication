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
        self.tabBar.backgroundColor = hexStringToUIColor(hex: "174688")
        self.tabBar.unselectedItemTintColor = hexStringToUIColor(hex: "#b0b0b0")
        self.tabBar.tintColor = .white
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
