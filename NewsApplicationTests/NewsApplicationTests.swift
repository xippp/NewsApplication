//
//  NewsApplicationTests.swift
//  NewsApplicationTests
//
//  Created by Paul on 31/5/2567 BE.
//

import XCTest
import RxSwift
import RxCocoa
@testable import NewsApplication

final class NewsApplicationTests: XCTestCase {
    
    var viewModel: MainViewModel!
    var mockupNetwork: MockNetwork!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        mockupNetwork = MockNetwork()
        viewModel = MainViewModel(network: mockupNetwork)
    }
    
    override func tearDown() {
        disposeBag = nil
        mockupNetwork = nil
        viewModel = nil
        super.tearDown()
    }

    func testFetchTopHeadlineAll_Success() {
        let expectation = self.expectation(description: "Success")
        
        let newsModel = NewsModel(status: "ok" ,code: "", message: "",articles: [Article(source: Source(id: "", name: ""), author: "", title: "Test", description: "", url: "", urlToImage: "", publishedAt: "", content: "")])
        mockupNetwork.result = .success(newsModel)

        viewModel.topHeadlinesAllObservable
            .subscribe(onNext: { articles in
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles.first?.title, "Test")
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.fetchTopHeadlineAll(country: "us")
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
