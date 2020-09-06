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

    func test_ParsingResponse() throws {
        // Given
        let expected_char_id = 1
        let expected_name = "Walter White"
        let expected_occupations = [
            "High School Chemistry Teacher",
            "Meth King Pin"
        ]
        let expected_imageURL = "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"
        let expected_appearances = [1, 2, 3, 4, 5]
        
        let mockJSONData =
            """
                [{
                "char_id": \(expected_char_id),
                "name": "\(expected_name)",
                "birthday": "09-07-1958",
                "occupation": \(expected_occupations),
                "img": "\(expected_imageURL)",
                "status": "Presumed dead",
                "nickname": "Heisenberg",
                "appearance": \(expected_appearances),
                "portrayed": "Bryan Cranston",
                "category": "Breaking Bad",
                "better_call_saul_appearance": []
                }]
            """.data(using: .utf8)!

        // When
        let response = try CharacterRequest().parseResponse(data: mockJSONData)
        
        // Then
        XCTAssertEqual(response.count, 1, "Expected a single Breaking Bad character")
        let bbCharacter = response.first!
        // Sanity check for the expected character
        XCTAssertEqual(bbCharacter.char_id, expected_char_id, "Unexpected character id")
        XCTAssertEqual(bbCharacter.name, expected_name, "Unexpected character name")
        
        // Verify that JSON mappings are correctly translated
        XCTAssertEqual(bbCharacter.occupations, expected_occupations, "Unexpected occupations for \(bbCharacter.name)")
        XCTAssertEqual(bbCharacter.imageURL, expected_imageURL, "Unexpected URL for character image")
        XCTAssertEqual(bbCharacter.appearances, expected_appearances, "Unexpected season appearances for character")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
