//
//  UIViewController+Extension.swift
//  NewsApplication
//
//  Created by Paul on 4/6/2567 BE.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func showPopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
