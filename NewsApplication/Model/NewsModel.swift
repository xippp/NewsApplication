//
//  NewsModel.swift
//  NewsApplication
//
//  Created by Paul on 1/6/2567 BE.
//

import Foundation

// MARK: - Welcome
struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    var topic: String?
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
