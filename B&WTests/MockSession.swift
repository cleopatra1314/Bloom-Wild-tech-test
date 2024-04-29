//
//  MockSession.swift
//  B&WTests
//
//  Created by cleopatra on 2024/4/29.
//  Copyright © 2024 Artemis Simple Solutions Ltd. All rights reserved.
//

import Foundation
@testable import B_W

// Changes: Mock urlSession

protocol URLSessionDataTaskProtocol {
    func resume()
}

class MockURLSession: NetworkSessionManager {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
  
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {

        lastURL = request.url
        
        completion(nextData, successHttpURLResponse(request: request), nextError)

        return nextDataTask
    }
  
  }

class MockURLSessionDataTask: NetworkCancellable {
    
    private (set) var resumeWasCalled = false
    
    func cancel() {
        
    }
    
    func resume() {
        resumeWasCalled = true
    }
}

class MockApiService: NetworkService {
    
    var isFetchPopularPhotoCalled = false
    var networkCancellable: NetworkCancellable!
    
    func request(endpoint: B_W.Requestable, completion: @escaping CompletionHandler) -> B_W.NetworkCancellable? {
        isFetchPopularPhotoCalled = true
        
        return networkCancellable
    }

}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
