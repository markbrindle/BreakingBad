//
//  CharactersController.swift
//  BreakingBad
//
//  Created by Mark Brindle on 08/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import Foundation

class CharactersController: ObservableObject {
    @Published public private(set) var characters: [BBCharacter] {
        willSet {
            objectWillChange.send()
        }
    }
    var urlSession = URLSession.shared

    internal init(_characters: Published<[BBCharacter]> = Published(initialValue: [])) {
        self._characters = _characters
    }
    
    func loadData() {
        var results = [BBCharacter]()

        // Call out to get BB characters from https://breakingbadapi.com/api/characters
        let request = CharacterRequest()
        let loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
        loader.loadAPIRequest(requestData: nil) { (bbCharacters, error) in
            if let error = error {
                // Handle the error as appropriate.  Here, the error is printed.
                print("Error loading BB characters: \(error.localizedDescription)")
                // Then we load some fallback data, just so the app has something to display
                results = self.loadFallbackData()
            } else if let bbCharacters = bbCharacters {
                results = bbCharacters
            }
            
            DispatchQueue.main.async {
                self.characters = results
            }
            
        }
    }
    
    func filteredCharacters(with characterName: String? = nil, season: Int? = nil) -> [BBCharacter] {
        let filtered = characters.filter { $0.contains(characterName) }
        if let season = season {
            return Array(filtered.filter { $0.appearances.contains(season) } )
        }
        return filtered
    }
}

extension CharactersController {

    private func loadFallbackData() -> [BBCharacter] {
        // Offline fallback - in case a loading error is encountered
        do {
            return try CharacterRequest().parseResponse(data: CharactersRawData.allCharacters()!)
        } catch {
            print("Failed to create Breaking Bad characters from fallback data - \nError: \(error.localizedDescription)")
        }
        return []

    }
}
