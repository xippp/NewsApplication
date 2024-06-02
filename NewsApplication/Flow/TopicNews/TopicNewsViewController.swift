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
    
    var mainModel: MainViewModel!
    var viewModel = TopicNewsViewModel()
    var articleModel: NewsModel?
//    MARK: -IBOutlet Properties

    @IBOutlet weak var newsImageTableView: UITableView! {
        didSet {
            newsImageTableView.register(UINib(nibName: "NewsImageTableTableViewCell", bundle: nil), forCellReuseIdentifier: "newsImageTableCell")
            newsImageTableView.dataSource = self
            newsImageTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(self.articleModel?.topic) News Topic"
        print("TopicNewsViewController")
    }
    
    func setupObservable() {
        mainModel.topicNewsObservable.subscribe { newsModel in
            self.articleModel = newsModel
        }
    }
}

extension TopicNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleModel?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsImageTableCell", for: indexPath) as? NewsImageTableTableViewCell else { return UITableViewCell() }
        cell.setImage = self.articleModel?.articles[indexPath.row].urlToImage
        return cell
    }
    
    
}
