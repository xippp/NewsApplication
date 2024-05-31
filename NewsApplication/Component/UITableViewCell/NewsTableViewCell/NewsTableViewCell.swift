//
//  NewsTableViewCell.swift
//  NewsApplication
//
//  Created by Paul on 31/5/2567 BE.
//

import UIKit
@IBDesignable
class NewsTableViewCell: UITableViewCell {

//    MARK: -IBOutlet Properties
    
    
    @IBOutlet weak var sectionNewsTab: SectionNewsTab!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
