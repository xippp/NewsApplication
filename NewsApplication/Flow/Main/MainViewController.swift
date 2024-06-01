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
class MainViewController: UIViewController {
    
    var viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
//    MARK: -IBOutlet Properties
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.delegate = self
            newsTableView.dataSource = self
            newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsTableCell")
        }
    }
    
    override func viewDidLoad() {
        print("Hello Come To Main News page")
        setupObservable()
        viewModel.fetchTopHeadlineAll(country: "th")
    }
    
    func fetchTopHeadline() {
        viewModel.topHeadlinesAllObservable.subscribe { newsModel in
            print("Top Headline News is: \(newsModel)")
            self.viewModel.fetchNewsSpecific(source: "Apple")
        }.disposed(by: disposeBag)
    }
    
    func fetchSpecificNews() {
        viewModel.specificNewsObservable.subscribe { specificNewsModel in
            print("Specific News is: \(specificNewsModel)")
        }.disposed(by: disposeBag)
    }
    
    func setupObservable() {
        fetchTopHeadline()
        fetchSpecificNews()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
}
