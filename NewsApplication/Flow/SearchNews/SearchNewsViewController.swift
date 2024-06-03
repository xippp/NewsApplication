//
//  SearchNewsViewController.swift
//  NewsApplication
//
//  Created by Paul on 3/6/2567 BE.
//

import Foundation
import UIKit

class SearchNewsViewController: UIViewController {
    
//    MARK: -IBOutlet Properties
    
    
    @IBOutlet weak var searchFieldView: SearchFieldView!
    
    @IBOutlet weak var searchNewsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Search NewsViewController")
    }
}
