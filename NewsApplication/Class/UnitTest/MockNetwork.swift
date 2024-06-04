//
//  MockNetwork.swift
//  NewsApplication
//
//  Created by Paul on 4/6/2567 BE.
//

import Foundation

class MockNetwork: Network {
    var result: Result<NewsModel, Error>!
    
    
    override func callTopHeadline(country: String) async throws -> NewsModel {
        switch result {
        case .success(let newsModel):
            return newsModel
        case .failure(let error):
            throw error
        case .none:
            fatalError("Mock result not set")
        }
    }
    
    
}
