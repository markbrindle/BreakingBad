//
//  GenericCodingKeys.swift
//  BreakingBad
//
//  Created by Mark Brindle on 06/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import Foundation

struct GenericCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
}
