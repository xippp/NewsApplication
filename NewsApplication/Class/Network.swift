//
//  Network.swift
//  NewsApplication
//
//  Created by Paul on 1/6/2567 BE.
//

import Foundation

class Network {
    
    var serverURL = "https://newsapi.org"
    
    func callTopHeadline(country: String) async throws -> NewsModel {
        let url = "\(serverURL)/v2/top-headlines?country=\(country)&pageSize=10&category=technology&apiKey=\(Configuration.shared.apiKey)"
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, responseURL) = try await URLSession.shared.data(for: request)
        if let httpResponse = responseURL as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    throw URLError(.badServerResponse)
                }
        let response = try JSONDecoder().decode(NewsModel.self, from: data)
        return response
    }
    
    func callTopHeadlineSpecific(source: String) async throws -> NewsModel {
        let url = "\(serverURL)/v2/top-headlines?q=\(source)&pageSize20&apiKey=\(Configuration.shared.apiKey)"
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, responseURL) = try await URLSession.shared.data(for: request)
        if let httpREsponse = responseURL as? HTTPURLResponse, !(200...299).contains(httpREsponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        let response = try JSONDecoder().decode(NewsModel.self, from: data)
        
        return response
    }
    
    func callSeachNews(query: String) async throws -> NewsModel {
        let url = "\(serverURL)/v2/everything?q=\(query)&pageSize20&searchIn=title,content&language=en&apiKey=\(Configuration.shared.apiKey)"
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, responseURL) = try await URLSession.shared.data(for: request)
        if let httpResponse = responseURL as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        let response = try JSONDecoder().decode(NewsModel.self, from: data)
        
        return response
    }
    
}
