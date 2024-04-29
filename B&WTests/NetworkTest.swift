//
//  HttpClientTests.swift
//  B&WTests
//
//  Created by cleopatra on 2024/4/25.
//  Copyright © 2024 Artemis Simple Solutions Ltd. All rights reserved.
//

import XCTest
@testable import B_W

// Changes: Test

final class NetworkTest: XCTestCase {

    var sut: DefaultNetworkService!
    let session = MockURLSession()
    
    override func setUpWithError() throws {

        let mockProduct = Product(id: "Test Product",
                              name: "This is a test product",
                              description: "Test description",
                              price: "20",
                                  rating: 3.7,
                              imagePath: "https://miro.medium.com/v2/resize:fit:640/format:webp/0*LkjfSwtEA2-cLCDz")
        if let url = URL(string: mockProduct.imagePath!){
            let urlRequest = URLRequest(url: url)
            let requestConfig = ApiRequestConfig(baseURL: url)
            
            sut = DefaultNetworkService(config: requestConfig, sessionManager: session)
        }

    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_get_request_with_URL() {
      
        guard let url = URL(string: "https://www.bloomandwild.com") else {
          fatalError("URL can't be empty")
        }
      
        let endpoint = URLRequest(url: url)

        let networkCancellable = sut.request(request: endpoint, completion: { result in
            
        })

        XCTAssertEqual(session.lastURL, url)
        XCTAssertNotNil(networkCancellable)
    }

}

