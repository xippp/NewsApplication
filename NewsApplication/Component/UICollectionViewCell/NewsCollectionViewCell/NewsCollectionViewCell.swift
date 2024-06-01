//
//  NewsCollectionViewCell.swift
//  NewsApplication
//
//  Created by Paul on 31/5/2567 BE.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var roundCornerView: UIView! {
        didSet {
            roundCornerView.layer.cornerRadius = 20
            roundCornerView.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
