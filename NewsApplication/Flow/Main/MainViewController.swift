//
//  MainViewController.swift
//  NewsApplication
//
//  Created by Paul on 31/5/2567 BE.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class MainViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate {
    
    var viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    var allData: [NewsModel] = []
    var topHeadlineNews: NewsModel?
    var specificNews: NewsModel?
    var dataToDisplay: [Article] = []
//    MARK: -IBOutlet Properties
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsTableCell")
        }
    }
    
    override func viewDidLoad() {
        print("Hello Come To Main News page")
        setupObservable()
        viewModel.fetchTopHeadlineAll(country: "us")
    }
    
    func setupObservable() {
        newsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.newsDataObservable.bind(to: newsTableView.rx.items(cellIdentifier: "newsTableCell", cellType: NewsTableViewCell.self)) { row, item, cell in
                    self.dataToDisplay = item.articles.filter { $0.urlToImage?.isEmpty != nil }
                    if !self.dataToDisplay.isEmpty {
                        if row == 0 {
                            cell.sectionNewsTab.setText = "Treading News"
                        } else if row == 1 {
                            cell.sectionNewsTab.setText = "Apple News"
                        }
                        cell.setupNewsCollection(with: Observable.just(item.articles.filter { $0.urlToImage?.isEmpty != nil}))
                        cell.articleSelected.subscribe(onNext: { articel in
                            self.openWebNews(url: articel.url)
                        }).disposed(by: self.disposeBag)
                    } else {

                    }
                }
        self.viewModel.fetchNewsSpecific(source: "Apple")
    }

    
    private func openWebNews(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.openURL(url)
        } else { return }
        
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if self.dataToDisplay.isEmpty {
                return 0
            } else {
                return UITableView.automaticDimension
            }
            
        }
    
}

//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
//        return cell
//    }
//    

//    
//}
