//
//  NewsTableViewCell.swift
//  NewsApplication
//
//  Created by Paul on 31/5/2567 BE.
//

import UIKit
import RxSwift
import RxCocoa
@IBDesignable
class NewsTableViewCell: UITableViewCell{
    
    var newsModel: Observable<[Article]>?
    var disposeBag = DisposeBag()
    var articleSelected = PublishSubject<Article>()
//    MARK: -IBOutlet Properties
    @IBOutlet weak var sectionNewsTab: SectionNewsTab!
    
    @IBOutlet weak var newsCollectionView: UICollectionView! {
        didSet {
            newsCollectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newsCollectionCell")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupNewsCollection(with items: Observable<[Article]>) {
        self.newsModel = items.take(10)
        self.newsModel?.bind(to: newsCollectionView.rx.items(cellIdentifier: "newsCollectionCell", cellType: NewsCollectionViewCell.self)) { index, item, cell in
            
            cell.setImage = item.urlToImage ?? ""
        }.disposed(by: disposeBag)
        
        newsCollectionView.rx.modelSelected(Article.self).bind(to: articleSelected).disposed(by: disposeBag)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCollectionCell", for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
//        return cell
//    }
    
}
