//
//  MainViewModel.swift
//  NewsApplication
//
//  Created by Paul on 1/6/2567 BE.
//

import Foundation
import RxSwift
import RxCocoa
class MainViewModel {
    
    var network = Network()
    
    var topHeadlinesAll: PublishSubject<NewsModel> = PublishSubject()
    var specificNews: PublishSubject<NewsModel> = PublishSubject()
    
    var topHeadlinesAllObservable: Observable<NewsModel> {
        topHeadlinesAll.asObservable()
    }
    var specificNewsObservable: Observable<NewsModel> {
        specificNews.asObservable()
    }
    
    func fetchTopHeadlineAll(country: String) {
        Task {
            do {
              let newsModel = try await network.callTopHeadline(country: country)
                topHeadlinesAll.onNext(newsModel)
            } catch {
                print("Error is: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNewsSpecific(source: String) {
        Task {
            do {
                let newsModel = try await network.callTopHeadlineSpecific(source: source)
                specificNews.onNext(newsModel)
            } catch {
                print("Error is: \(error.localizedDescription)")
            }
        }
    }
    
}
