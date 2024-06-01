//
//  NewsTableViewCell.swift
//  NewsApplication
//
//  Created by Paul on 31/5/2567 BE.
//

import UIKit
@IBDesignable
class NewsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    MARK: -IBOutlet Properties
    
    
    @IBOutlet weak var sectionNewsTab: SectionNewsTab!
    
    @IBOutlet weak var newsCollectionView: UICollectionView! {
        didSet {
            newsCollectionView.dataSource = self
            newsCollectionView.delegate = self
            newsCollectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newsCollectionCell")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCollectionCell", for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
}
