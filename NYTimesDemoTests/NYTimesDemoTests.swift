//
//  NYTimesDemoTests.swift
//  NYTimesDemoTests
//
//  Created by Jhanvi on 24/07/18.
//  Copyright © 2018 Jhanvi. All rights reserved.
//

import XCTest
@testable import NYTimesDemo

class NYTimesDemoTests: XCTestCase {
    let articleData = [Constants.url: "https://www.google.com",
                       Constants.abstract: "Unit Test Abstract",
                       Constants.byline: "By Jhanvi",
                       Constants.title: "Unit Test Title",
                       Constants.publishedDate: "2018-07-24"]
    var sessionUnderTest: URLSession!

    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testArticles() {
        do {
            _ = try Article.init(dictionary: articleData)
        } catch {
            XCTAssert(false)
        }
    }
    
    func testValidCallToAPI() {
        // given
        let apikey = "af5c50d2ae89471f9a9cda8f0263ee19"
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(apikey)")
        
        let promise = expectation(description: "Response data not nil")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let responseRecevied = (response as? HTTPURLResponse) {
                if responseRecevied != nil {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("No response")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Asynchronous test: faster fail
    func testCallToiTunesCompletes() {
        let apikey = "af5c50d2ae89471f9a9cda8f0263ee19"
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(apikey)")
        
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
