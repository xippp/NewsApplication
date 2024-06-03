//
//  DetailNews.swift
//  NewsApplication
//
//  Created by Paul on 3/6/2567 BE.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher
class DetailNewsViewController: UIViewController {
    
    var topicModel: TopicNewsViewModel?
    var articleData: Article?
    var mainModel: MainViewModel?
    var disposeBag = DisposeBag()
//    MARK: -IBOutlet Properties
    
    @IBOutlet weak var cornerView: UIView! {
        didSet {
            cornerView.layer.cornerRadius = 20
            cornerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var titleNews: UILabel!
    
    @IBOutlet weak var detailNews: UITextView!
    
    @IBOutlet weak var webButton: UIButton! {
        didSet {
            webButton.setTitle("View news on website", for: .normal)
            webButton.setTitleColor(.black, for: .normal)
            webButton.tintColor = .blue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        setupUI()
        print("DetailNewsViewController")
    }
    
    func setupObservable() {
        topicModel?.selectNewsObservable.subscribe(onNext: { article in
            self.articleData = article
        }).disposed(by: disposeBag)
        mainModel?.detailsNewsObservable.subscribe(onNext: { article in
            self.articleData = article
        }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        if let url = URL(string: self.articleData?.urlToImage ?? "") {
            self.newsImage.kf.setImage(with: url)
        } else {
            self.newsImage.image = UIImage(named: "placeholderImage")
        }
        self.titleNews.text = self.articleData?.title
        self.detailNews.text = self.articleData?.description
    }
    
    @IBAction func openWebNews(_ sender: Any) {
        if let url = URL(string: self.articleData?.url ?? "") {
            UIApplication.shared.openURL(url)
        } else { return }
    }
}
