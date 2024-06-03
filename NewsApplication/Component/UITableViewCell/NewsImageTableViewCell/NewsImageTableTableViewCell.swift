//
//  NewsImageTableTableViewCell.swift
//  NewsApplication
//
//  Created by Paul on 3/6/2567 BE.
//

import UIKit
import Kingfisher
class NewsImageTableTableViewCell: UITableViewCell {
    
    var setImage: String? {
        didSet {
            if let url = URL(string: setImage ?? "") {
                newsImage.kf.setImage(with: url)
            } else {
                newsImage.image = UIImage(named: "placeholderImage")
            }
        }
    }
    
    var setTitle: String = "" {
        didSet {
            titleNewsLabel.text = setTitle
        }
    }
    
    @IBOutlet weak var cornerView: UIView! {
        didSet {
            cornerView.layer.cornerRadius = 20
            cornerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var titleNewsLabel: UILabel! {
        didSet {
            titleNewsLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
