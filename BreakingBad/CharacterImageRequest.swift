//
//  CharacterImageRequest.swift
//  BreakingBad
//
//  Created by Mark Brindle on 11/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import UIKit

struct CharacterImageRequest {
    
    func makeRequest(from urlString: String) throws -> URLRequest {
        guard urlString.isEmpty == false, let url = URL(string: urlString) else {
            throw RequestError.invalidURLString
        }
        return URLRequest(url: url)
    }
    
    func parseResponse(data: Data) throws -> UIImage? {
        if let img = UIImage.init(data: data) {
            return img
        }
        return nil
    }
}

extension CharacterImageRequest: APIRequest {}
