//
//  SearchNewsViewModel.swift
//  NewsApplication
//
//  Created by Paul on 3/6/2567 BE.
//

import Foundation
import RxSwift

class SearchNewsViewModel {
    
    var network = Network()
    var searchSubject:PublishSubject<String> = PublishSubject()
    var getNewsSubject: PublishSubject<[Article]> = PublishSubject()
    var selectNews: PublishSubject<Article> = PublishSubject()

    var searchObservable: Observable<String> {
        searchSubject.asObservable()
    }
    var getNewsObservable: Observable<[Article]> {
        getNewsSubject.asObservable()
    }
    
    var selectNewsObservable: Observable<Article> {
        selectNews.asObservable()
    }
    
    func fetchSearchNews() {
        searchSubject.subscribe { query in
            Task {
                do {
                    let newsModel = try await self.network.callSeachNews(query: query)
                    self.getNewsSubject.onNext(newsModel.articles)
                } catch {
                    print("Error is: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getArticleSelected(article: Article) {
        selectNews.onNext(article)
    }
    
}
