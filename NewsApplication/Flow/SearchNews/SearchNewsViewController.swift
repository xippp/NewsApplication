//
//  SearchNewsViewController.swift
//  NewsApplication
//
//  Created by Paul on 3/6/2567 BE.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class SearchNewsViewController: UIViewController {
    
    var viewModel = SearchNewsViewModel()
    var disposeBag = DisposeBag()
    var newsArticle: [Article] = []
    let debounceTime = 2.0
//    MARK: -IBOutlet Properties
    @IBOutlet weak var searchFieldView: SearchFieldView!
    
    @IBOutlet weak var searchNewsTableView: UITableView! {
        didSet {
            searchNewsTableView.register(UINib(nibName: "NewsImageTableTableViewCell", bundle: nil), forCellReuseIdentifier: "newsImageTableCell")
            searchNewsTableView.dataSource = self
            searchNewsTableView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Search NewsViewController")
        setupTapGesture()
        setupObservable()
    }
    
    private func setupObservable() {
        searchFieldView.searchField.rx.text
            .orEmpty
            .debounce(.seconds(Int(debounceTime)), scheduler: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .bind(to: viewModel.searchSubject).disposed(by: disposeBag)
            
        viewModel.getNewsObservable
            .subscribe { article in
                self.newsArticle = article
                self.newsArticle = self.newsArticle.filter { $0.urlToImage?.isEmpty != nil }
                DispatchQueue.main.async {
                    self.searchNewsTableView.reloadData()
                }
        }.disposed(by: disposeBag)
        
//        viewModel.resultSubject.asObservable().subscribe { movies in
//            print(movies)
//            self.moviesResult = movies
//            self.searchTableView.reloadData()
//        }.disposed(by: bag)
        
        viewModel.showPopupObservable.subscribe { popupModel in
            self.showPopup(title: popupModel.code ?? "", message: popupModel.message ?? "")
        }
        
        viewModel.fetchSearchNews()

    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
        
    }
    
}

extension SearchNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsImageTableCell", for: indexPath) as? NewsImageTableTableViewCell else { return UITableViewCell() }
        cell.setImage = self.newsArticle[indexPath.row].urlToImage
        cell.setTitle = self.newsArticle[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = DetailNewsViewController(nibName: "DetailNews", bundle: nil)
        destinationVC.searchModel = viewModel
        destinationVC.setupObservable()
        viewModel.getArticleSelected(article: self.newsArticle[indexPath.row])
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
