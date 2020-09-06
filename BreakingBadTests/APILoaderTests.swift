//
//  APILoaderTests.swift
//  BreakingBadTests
//
//  Created by Mark Brindle on 06/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import XCTest
@testable import BreakingBad

class APILoaderTests: XCTestCase {
    
    var loader: APIRequestLoader<CharacterRequest>!
    
    override func setUp() {
        let request = CharacterRequest()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoaderSuccess() throws {
        // Given
        let expected_walter_id = 1
        let expected_jesse_id = 2

        let mockJSONData =
            """
                [{
                "char_id": \(expected_walter_id),
                "name": "Walter White",
                "birthday": "09-07-1958",
                "occupation": [
                    "High School Chemistry Teacher",
                    "Meth King Pin"
                ],
                "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
                "status": "Presumed dead",
                "nickname": "Heisenberg",
                "appearance": [1, 2, 3, 4, 5],
                "portrayed": "Bryan Cranston",
                "category": "Breaking Bad",
                "better_call_saul_appearance": []
                },
                {
                    "char_id": \(expected_jesse_id),
                    "name": "Jesse Pinkman",
                    "birthday": "09-24-1984",
                    "occupation": [
                        "Meth Dealer"
                    ],
                    "img": "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Jesse_Pinkman2.jpg/220px-Jesse_Pinkman2.jpg",
                    "status": "Alive",
                    "nickname": "Cap n' Cook",
                    "appearance": [
                        1,
                        2,
                        3,
                        4,
                        5
                    ],
                    "portrayed": "Aaron Paul",
                    "category": "Breaking Bad",
                    "better_call_saul_appearance": [

                    ]
                }]
            """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.scheme, "https", "Unexpected scheme in request" )
            XCTAssertEqual(request.url?.host, "breakingbadapi.com", "Unexpected host in request" )
            return (HTTPURLResponse(), mockJSONData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: nil) { (bbCharacters, error) in
            guard let bbCharacters = bbCharacters else {
                XCTFail("No breaking bad characters in response")
                return
            }
            XCTAssertEqual(bbCharacters.count, 2, "Expected two characters")
            let walter = bbCharacters.first!  // Safe to force here as the assertion above would already have failed
            XCTAssertEqual(walter.char_id, expected_walter_id, "Unexpected character id in response for Walter")
            let jesse = bbCharacters.last!  // Safe to force here as the assertion above would already have failed
            XCTAssertEqual(jesse.char_id, expected_jesse_id, "Unexpected character id in response for Jesse")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

