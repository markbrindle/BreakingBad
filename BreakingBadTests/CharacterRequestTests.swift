//
//  CharacterRequestTests.swift
//  BreakingBadTests
//
//  Created by Mark Brindle on 06/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import XCTest
@testable import BreakingBad

class CharacterRequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MakingURLRequest() throws {
        // Given
        let urlRequest = try CharacterRequest().makeRequest(from: nil)
        
        // Then
        XCTAssertEqual(urlRequest.url?.scheme, "https", "Expected a scheme")
        XCTAssertEqual(urlRequest.url?.host, "breakingbadapi.com", "Expected a host")
        XCTAssertNil(urlRequest.url?.query, "Expected no query to be set")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
