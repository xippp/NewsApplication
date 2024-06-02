//
//  TopicNewsViewModel.swift
//  NewsApplication
//
//  Created by Paul on 2/6/2567 BE.
//

import Foundation
import RxSwift

class TopicNewsViewModel {
    
    var selectNews: PublishSubject<Article> = PublishSubject()

    var selectNewsObservable: Observable<Article> {
        selectNews.asObservable()
    }
    
    func getNews(articel: Article) {
        selectNews.onNext(articel)
    }
    
}
