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
class MainViewController: UIViewController, UIScrollViewDelegate, SectionNewsDelegate{
    var viewModel = MainViewModel()
    
    private let disposeBag = DisposeBag()
    var allData: [NewsModel] = []
    var topHeadlineNews: NewsModel?
    var specificNews: NewsModel?
    var dataToDisplay: [Article] = []
    var dataTopBreakingNews: [Article] = []
    var topicNews: [String] = ["Apple", "Tesla", "Crypto"]
    let articleSelected = PublishSubject<Article>()
    var timer: Timer?
    var currentCellIndex = 0
//    MARK: -IBOutlet Properties
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsTableCell")
        }
    }
    
    @IBOutlet weak var topBreakingCollection: UICollectionView! {
        didSet {
            topBreakingCollection.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newsCollectionCell")
            topBreakingCollection.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        print("Hello Come To Main News page")
        self.title = "News"
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        setupObservable()
        viewModel.fetchTopHeadlineAll(country: "us")
    }
    
    @objc func slideToNext() {
        if self.dataTopBreakingNews.count != 0 {
            if currentCellIndex < self.dataTopBreakingNews.count-1 {
                currentCellIndex = currentCellIndex + 1
            } else {
                currentCellIndex = 0
            }
            topBreakingCollection.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        }
    }
    
    private func setupObservable() {
        viewModel.topHeadlinesAllObservable.subscribe { article in
            DispatchQueue.main.async {
                self.dataTopBreakingNews = article
                self.pageControl.numberOfPages = article.count
            }
            for topic in self.topicNews {
                self.viewModel.fetchNewsSpecific(source: topic)
            }
        }.disposed(by: disposeBag)
        
        viewModel.topHeadlinesAllObservable.bind(to: self.topBreakingCollection.rx.items(cellIdentifier: "newsCollectionCell", cellType: NewsCollectionViewCell.self)) { row, item, cell in
            cell.setImage = item.urlToImage ?? ""
            
            print(row)
        }.disposed(by: disposeBag)
        
        articleSelected.subscribe(onNext: { article in
            self.routeToDetail(article: article)
        }).disposed(by: self.disposeBag)
        
        self.newsTableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.viewModel.newsDataObservable.bind(to: self.newsTableView.rx.items(cellIdentifier: "newsTableCell", cellType: NewsTableViewCell.self)) { row, item, cell in
            self.dataToDisplay = item.articles.filter { $0.urlToImage?.isEmpty != nil }
            cell.sectionNewsTab.delegate = self
            cell.sectionNewsTab.index = row
            cell.articleSelected = self.articleSelected
            if !self.dataToDisplay.isEmpty {
                cell.sectionNewsTab.setText = "\(item.topic ?? "") News Topic"
                cell.setupNewsCollection(with: Observable.just(item.articles.filter { $0.urlToImage?.isEmpty != nil}))
                
            } else {
                
            }
        }.disposed(by: disposeBag)
        
        
    }
    
    private func openWebNews(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.openURL(url)
        } else { return }
        
    }
    
    private func routeToDetail(article: Article) {
        let destinationVC = DetailNewsViewController(nibName: "DetailNews", bundle: nil)
        destinationVC.mainModel = viewModel
        destinationVC.setupObservable()
        viewModel.detailsNewsSubject.onNext(article)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
//    MARK: -Delegate From SectionNewsTab
    func buttonSellAllTapped(at index: Int) {
        let destinationVC = TopicNewsViewController(nibName: "TopicNews", bundle: nil)
        destinationVC.mainModel = viewModel
        destinationVC.setupObservable()
        viewModel.getTopicNews(index: index)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    

}

extension MainViewController: UITableViewDelegate, UICollectionViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataToDisplay.isEmpty {
            return 0
        } else {
            return UITableView.automaticDimension
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
        self.currentCellIndex = indexPath.row
    }
}
