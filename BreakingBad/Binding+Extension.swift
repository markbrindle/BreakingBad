//
//  Binding+Extension.swift
//  BreakingBad
//
//  Created by Mark Brindle on 10/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//
// Attribution to https://www.swiftbysundell.com/articles/getting-the-most-out-of-xcode-previews/

import SwiftUI

#if DEBUG
extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
#endif
