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
    var topicModel: NewsModel?
    var articleModel : [Article] = []
    var disposedBag = DisposeBag()
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
        self.title = self.topicModel?.topic ?? ""
        print("TopicNewsViewController")
    }
    
    func setupObservable() {
        mainModel.topicNewsObservable
            .subscribe(onNext: { newsModel in
                self.topicModel = newsModel
                self.articleModel = self.topicModel?.articles.filter { $0.urlToImage != nil} ?? []
            }).disposed(by: disposedBag)
    }
}

extension TopicNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsImageTableCell", for: indexPath) as? NewsImageTableTableViewCell else { return UITableViewCell() }
        cell.setImage = self.articleModel[indexPath.row].urlToImage
        cell.setTitle = self.articleModel[indexPath.row].title ?? ""
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = DetailNewsViewController(nibName: "DetailNews", bundle: nil)
        destinationVC.topicModel = viewModel
        destinationVC.setupObservable()
        viewModel.getNews(articel: self.articleModel[indexPath.row])
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
