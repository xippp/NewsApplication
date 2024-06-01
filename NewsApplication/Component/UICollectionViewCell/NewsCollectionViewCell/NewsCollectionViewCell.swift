//
//  NewsCollectionViewCell.swift
//  NewsApplication
//
//  Created by Paul on 31/5/2567 BE.
//

import UIKit
import Kingfisher
class NewsCollectionViewCell: UICollectionViewCell {
    
//    MARK: -Properties
    
    var setImage: String = "" {
        didSet {
            if let url = URL(string: setImage) {
                imageNews.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
            } else {
                imageNews.image = UIImage(named: "placeholderImage")
            }
            
        }
    }
    
    @IBOutlet weak var roundCornerView: UIView! {
        didSet {
            roundCornerView.layer.cornerRadius = 20
            roundCornerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var imageNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
