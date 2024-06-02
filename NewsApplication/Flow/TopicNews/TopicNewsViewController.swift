//
//  TopicNews.swift
//  NewsApplication
//
//  Created by Paul on 2/6/2567 BE.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class TopicNewsViewController: UIViewController {
    
//    MARK: -IBOutlet Properties
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsTableCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TopicNewsViewController")
    }
}
