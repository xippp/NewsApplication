//
//  SearchFieldView.swift
//  NewsApplication
//
//  Created by Paul on 3/6/2567 BE.
//

import Foundation
import UIKit

class SearchFieldView: UIView {
    
    var getText: String {
        get {
            return searchField.text ?? ""
        }
    }
    
    @IBOutlet weak var searchField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configView()
    }
    
    private func configView() {
        guard let view = self.loadViewFromNib(nibName: "SearchFieldView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}
