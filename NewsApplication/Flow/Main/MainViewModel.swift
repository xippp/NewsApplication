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
    
    var num = 0
    var network: Network
    
    init(network: Network) {
        self.network = network
    }
//    Subject FetchApi
    
    var showPopupErrorSubject: PublishSubject<PopupModel> = PublishSubject()
    
    var topHeadlinesAll: PublishSubject<[Article]> = PublishSubject()
    var newsData: PublishSubject<[NewsModel]> = PublishSubject()
    var topicNewsSubject: PublishSubject<NewsModel> = PublishSubject()
    var detailsNewsSubject: PublishSubject<Article> = PublishSubject()
    
    var showPopupErrorObservable: Observable<PopupModel> {
        showPopupErrorSubject.asObservable()
    }
    
    var topHeadlinesAllObservable: Observable<[Article]> {
        topHeadlinesAll.asObservable()
    }
    
    var newsDataObservable: Observable<[NewsModel]> {
        newsData.asObservable()
    }
    
    var topicNewsObservable: Observable<NewsModel> {
        topicNewsSubject.asObservable()
    }
    
    var detailsNewsObservable: Observable<Article> {
        detailsNewsSubject.asObservable()
    }
    
    var newsArray: [NewsModel] = []
    
    func fetchTopHeadlineAll(country: String) {
        Task {
            do {
              let newsModel = try await network.callTopHeadline(country: country)
                if newsModel.status == "error" {
                    let popupModel = PopupModel(status: newsModel.status, code: newsModel.code ?? "", message: newsModel.message ?? "")
                    showPopupErrorSubject.onNext(popupModel)
                } else {
                    topHeadlinesAll.onNext(newsModel.articles.filter { $0.urlToImage?.isEmpty != nil})
                }
            } catch {
                print("Error is: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNewsSpecific(source: String) {
        Task {
            do {
                var newsModel = try await network.callTopHeadlineSpecific(source: source)
                if newsModel.status == "error" {
                    let popupModel = PopupModel(status: newsModel.status, code: newsModel.code ?? "", message: newsModel.message ?? "")
                    showPopupErrorSubject.onNext(popupModel)
                } else {
                    newsModel.topic = source
                    self.newsArray.append(newsModel)
                    newsData.onNext(self.newsArray)
                }

            } catch {
                print("Error is: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopicNews(index: Int) {
        let topicNews = self.newsArray[index]
        topicNewsSubject.onNext(topicNews)
    }
    
}
