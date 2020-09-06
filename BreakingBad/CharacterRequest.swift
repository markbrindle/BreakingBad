//
//  CharacterRequest.swift
//  BreakingBad
//
//  Created by Mark Brindle on 06/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import Foundation

struct CharacterRequest {
    
    func makeRequest(from data: String?) throws -> URLRequest {
        let urlString: String = data ?? "https://breakingbadapi.com/api/characters"
        if urlString.isEmpty {
        }
        guard urlString.isEmpty == false, let url = URL(string: urlString) else {
            throw RequestError.invalidURLString
        }
        return URLRequest(url: url)
    }
    
    func parseResponse(data: Data) throws -> [BBCharacter] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .custom(BBCharacter.codingKeyMapper)
        return try decoder.decode([BBCharacter].self, from: data)
    }
}
