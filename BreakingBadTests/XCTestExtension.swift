//
//  XCTestExtension.swift
//  BreakingBadTests
//
//  Created by Mark Brindle on 08/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import XCTest
import Combine

extension XCTestCase {
    typealias CompletionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable)
    
    func expectValue<T: Publisher>(of publisher: T, timeout: TimeInterval = 2, file: StaticString = #file, line: UInt = #line, equals: [(T.Output) -> Bool]) -> CompletionResult {
        let exp = expectation(description: "Correct values of " + String(describing: publisher))
        var mutableEquals = equals
        let cancellable = publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    if mutableEquals.first?(value) ?? false {
                        _ = mutableEquals.remove(at: 0)
                        if mutableEquals.isEmpty {
                            exp.fulfill()
                        }
                    }
        })
        return (exp, cancellable)
    }
}
