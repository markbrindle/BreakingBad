//
//  BBCharacter.swift
//  BreakingBad
//
//  Created by Mark Brindle on 06/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import Foundation

struct BBCharacter {
    let char_id: Int
    let name: String
    let birthday: String
    let occupations: [String]
    let status: String
    let nickname: String
    let imageURL: String
    let appearances: [Int]

    static func codingKeyMapper(path: [CodingKey]) -> CodingKey {
        if path.count == 2 {
            switch path[1].stringValue {
                case "appearance": return GenericCodingKeys(stringValue: "appearances")!
                case "img": return GenericCodingKeys(stringValue: "imageURL")!
                case "occupation": return GenericCodingKeys(stringValue: "occupations")!
            default:
                break
            }
        }
        return path.last!
    }
}

extension BBCharacter: Decodable {}
