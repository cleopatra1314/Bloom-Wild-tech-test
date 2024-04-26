//
//  HttpClientTests.swift
//  B&WTests
//
//  Created by cleopatra on 2024/4/25.
//  Copyright © 2024 Artemis Simple Solutions Ltd. All rights reserved.
//

import XCTest
@testable import B_W

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

final class HttpClientTests: XCTestCase {
    
    var sut: DefaultProductDetailsViewModel!
    var httpClients: DefaultNetworkService!
    let session = MockURLSession()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // 初始化被測試的 DefaultNetworkService
//        httpClients = DefaultNetworkService(config: <#T##RequestConfig#> /* 在這裡傳入 RequestConfig 實例 */)
        
        // 初始化產品 ViewModel 的實例
        let mockProduct = Product(id: "Test Product",
                              name: "This is a test product",
                              description: "https://example.com/test.jpg",
                              price: "4.5",
                              rating: 19.99,
                              imagePath: "https://example.com/test.jpg")
        sut = DefaultProductDetailsViewModel(product: mockProduct)
        // Remove the private of imagePath
        let url = URL(string: sut.imagePath!)
        let mockRequestConfig = ApiRequestConfig(baseURL: url!)
        httpClients = DefaultNetworkService(config: <#T##RequestConfig#>)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        // 清理測試資源
    }

    func test_get_request_with_URL() {
      
        // 創建測試所需的 URL
        guard let url = URL(string: "https://mockurl") else {
          fatalError("URL can't be empty")
        }
      
        // 創建一個 URLRequest 物件
        let endpoint = URLRequest(url: url)
        
        // 定義完成處理器
        let completion: DefaultNetworkService.CompletionHandler = { result in
            switch result {
            case .success(let data):
                // 处理成功的情况
                print("Success: \(data)")
            case .failure(let error):
                // 处理失败的情况
                print("Error: \(error)")
            }
        }
        
        // 執行被測試的方法
        let cancellable = httpClients.request(endpoint: endpoint as! Requestable, completion: completion)
        
        // 断言最后一次 URL 是否等于预期的 URL
        XCTAssertEqual(session.lastURL, url)
        
        // 断言是否有返回 NetworkCancellable 實例
        XCTAssertNotNil(cancellable)
    }

}

// URLSession 的 dataTask() 就是我們想 mock 的目標
// 定義 MockURLSession 來模擬 URLSession 的行為
class MockURLSession: NetworkSessionManager {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
  
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> B_W.NetworkCancellable {
        
        // 保存最後一次的 URL
        lastURL = request.url
        
        // 執行 completion Closure
        completion(nextData, successHttpURLResponse(request: request), nextError)
        
        // 返回一個 NetworkCancellable 實例
        return nextDataTask as! NetworkCancellable
    }
    
//    func dataTask(with request: NSURLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
//  
//      lastURL = request.url
//  
//      completionHandler(nextData, successHttpURLResponse(request: request), nextError)
//  
//      return // dataTask
//    }
  
  }

// 定義 MockURLSessionDataTask 來模擬 URLSessionDataTask 的行為
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
