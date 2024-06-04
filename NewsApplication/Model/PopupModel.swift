//
//  popupModel.swift
//  NewsApplication
//
//  Created by Paul on 4/6/2567 BE.
//

import Foundation

class PopupModel {
    var status: String = ""
    var code: String?
    var message: String?
    
    init(status: String, code: String, message: String) {
        self.status = status
        self.code = code
        self.message = message
    }
}
