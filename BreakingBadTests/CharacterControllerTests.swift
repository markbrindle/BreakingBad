//
//  CharacterControllerTests.swift
//  BreakingBadTests
//
//  Created by Mark Brindle on 07/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import XCTest
@testable import BreakingBad
import SwiftUI

class CharacterControllerTests: XCTestCase {

    @ObservedObject var controller = CharactersController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadData() throws {
        // Given a mock character payload
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        MockURLProtocol.requestHandler = { request in
            (HTTPURLResponse(), self.mockCharacters)
        }
        controller.urlSession = urlSession
        // We expect 13 characters to be created from the mock data
        let result = expectValue(of: controller.$characters.eraseToAnyPublisher(), equals: [{ $0.count == 13 }])

        // When loading data
        controller.loadData()

        // Then character data is published
        wait(for: [result.expectation], timeout: 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    private var mockCharacters: Data = {
            """
                [
                    {
                        "char_id": 1,
                        "name": "Walter White",
                        "birthday": "09-07-1958",
                        "occupation": [
                            "High School Chemistry Teacher",
                            "Meth King Pin"
                        ],
                        "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
                        "status": "Presumed dead",
                        "nickname": "Heisenberg",
                        "appearance": [
                            1,
                            2,
                            3,
                            4,
                            5
                        ],
                        "portrayed": "Bryan Cranston",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 2,
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
                    },
                    {
                        "char_id": 3,
                        "name": "Skyler White",
                        "birthday": "08-11-1970",
                        "occupation": [
                            "House wife",
                            "Book Keeper",
                            "Car Wash Manager",
                            "Taxi Dispatcher"
                        ],
                        "img": "https://s-i.huffpost.com/gen/1317262/images/o-ANNA-GUNN-facebook.jpg",
                        "status": "Alive",
                        "nickname": "Sky",
                        "appearance": [
                            1,
                            2,
                            3,
                            4,
                            5
                        ],
                        "portrayed": "Anna Gunn",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 4,
                        "name": "Walter White Jr.",
                        "birthday": "07-08-1993",
                        "occupation": [
                            "Teenager"
                        ],
                        "img": "https://media1.popsugar-assets.com/files/thumbor/WeLUSvbAMS_GL4iELYAUzu7Bpv0/fit-in/1024x1024/filters:format_auto-!!-:strip_icc-!!-/2018/01/12/910/n/1922283/fb758e62b5daf3c9_TCDBRBA_EC011/i/RJ-Mitte-Walter-White-Jr.jpg",
                        "status": "Alive",
                        "nickname": "Flynn",
                        "appearance": [
                            1,
                            2,
                            3,
                            4,
                            5
                        ],
                        "portrayed": "RJ Mitte",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 5,
                        "name": "Henry Schrader",
                        "birthday": "Unknown",
                        "occupation": [
                            "DEA Agent"
                        ],
                        "img": "https://upload.wikimedia.org/wikipedia/en/thumb/c/c1/Hank_Schrader2.jpg/220px-Hank_Schrader2.jpg",
                        "status": "Deceased",
                        "nickname": "Hank",
                        "appearance": [
                            1,
                            2,
                            3,
                            4,
                            5
                        ],
                        "portrayed": "Dean Norris",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 12,
                        "name": "Tuco Salamanca",
                        "birthday": "Unknown",
                        "occupation": [
                            "Meth Distributor"
                        ],
                        "img": "https://vignette.wikia.nocookie.net/breakingbad/images/a/a7/Tuco_BCS.jpg/revision/latest?cb=20170810082445",
                        "status": "Deceased",
                        "nickname": "Tuco",
                        "appearance": [
                            1,
                            2
                        ],
                        "portrayed": "Raymond Cruz",
                        "category": "Breaking Bad, Better Call Saul",
                        "better_call_saul_appearance": [
                            1,
                            2
                        ]
                    },
                    {
                        "char_id": 13,
                        "name": "Marco & Leonel Salamanca",
                        "birthday": "Unknown",
                        "occupation": [
                            "Cartel Hitman"
                        ],
                        "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_the-cousins-lg.jpg",
                        "status": "Deceased",
                        "nickname": "The Cousins",
                        "appearance": [
                            3
                        ],
                        "portrayed": "Luis & Daniel Moncada",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 21,
                        "name": "Theodore Beneke",
                        "birthday": "Unknown",
                        "occupation": [
                            "Former President Beneke Fabricators"
                        ],
                        "img": "https://vignette.wikia.nocookie.net/breakingbad/images/b/bd/Cast_bb_700x1000_todd-beneke-lg.jpg/revision/latest?cb=20170723165057",
                        "status": "Alive",
                        "nickname": "Ted",
                        "appearance": [
                            2,
                            3,
                            4,
                            5
                        ],
                        "portrayed": "Christopher Cousins",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 32,
                        "name": "Jake Pinkman",
                        "birthday": "Unknown",
                        "occupation": [
                            "Kid",
                            "Jesse's little brother"
                        ],
                        "img": "https://vignette.wikia.nocookie.net/breakingbad/images/a/a4/Jake.jpg/revision/latest?cb=20121214201656&path-prefix=de",
                        "status": "Alive",
                        "nickname": "Jake",
                        "appearance": [
                            1
                        ],
                        "portrayed": "Ben Petry",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 39,
                        "name": "Holly White",
                        "birthday": "Unknown",
                        "occupation": [
                            "Infant"
                        ],
                        "img": "https://pmctvline2.files.wordpress.com/2013/09/breaking-bad-elanor-anne-wenrich-325.jpg?w=325&h=240",
                        "status": "Alive",
                        "nickname": "Holly",
                        "appearance": [
                            2,
                            3,
                            4,
                            5
                        ],
                        "portrayed": "Unknown",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 40,
                        "name": "George Merkert",
                        "birthday": "Unknown",
                        "occupation": [
                            "Former Head of Albuquerque DEA"
                        ],
                        "img": "https://m.media-amazon.com/images/M/MV5BMTkwMTkxNjUzM15BMl5BanBnXkFtZTgwMTg5MTczMTE@._V1_UY317_CR175,0,214,317_AL_.jpg",
                        "status": "Alive",
                        "nickname": "ASAC Merkert",
                        "appearance": [
                            2,
                            3,
                            4,
                            5
                        ],
                        "portrayed": "Michael Shamus Wiles",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 56,
                        "name": "Officer Saxton",
                        "birthday": "Unknown",
                        "occupation": [
                            "APD Officer"
                        ],
                        "img": "https://vignette.wikia.nocookie.net/breakingbad/images/f/f3/Officer_Saxton_-_I.F.T..png/revision/latest?cb=20131025090606",
                        "status": "Alive",
                        "nickname": "Saxton",
                        "appearance": [
                            3
                        ],
                        "portrayed": "Stoney Westmoreland",
                        "category": "Breaking Bad",
                        "better_call_saul_appearance": [

                        ]
                    },
                    {
                        "char_id": 117,
                        "name": "Stacey Ehrmantraut",
                        "birthday": "Unknown",
                        "occupation": [
                            "Mother"
                        ],
                        "img": "https://vignette.wikia.nocookie.net/breakingbad/images/b/b3/StaceyEhrmantraut.png/revision/latest?cb=20150310150049",
                        "status": "?",
                        "nickname": "Stacey",
                        "appearance": [

                        ],
                        "portrayed": "Kerry Condon",
                        "category": "Better Call Saul",
                        "better_call_saul_appearance": [
                            1,
                            2,
                            3,
                            4
                        ]
                    }
                ]
                """.data(using: .utf8)!
    }()

}
