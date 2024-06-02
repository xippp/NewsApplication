//
//  SectionNewsTab.swift
//  NewsApplication
//
//  Created by Paul on 31/5/2567 BE.
//

import Foundation
import UIKit

protocol SectionNewsDelegate: AnyObject {
    func buttonSellAllTapped(at index: Int)
}


class SectionNewsTab: UIView {
    
//    MARK: -Properties
    weak var delegate: SectionNewsDelegate?
    var index = 0
    var setText: String = "" {
        didSet {
            titleLabel.text = setText
        }
    }
    
//    MARK: -IBOutlet Propertise
    
    @IBOutlet weak var cornerTabView: UIView! {
        didSet {
            cornerTabView.layer.cornerRadius = 20
            cornerTabView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
//    MARK: -IBAction
    

    @IBAction func seeAllNews(_ sender: Any) {
        delegate?.buttonSellAllTapped(at: index)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configView()
    }
    
    private func configView() {
        guard let view = self.loadViewFromNib(nibName: "SectionNewsTab") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}
