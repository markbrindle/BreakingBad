//
//  CharactersController.swift
//  BreakingBad
//
//  Created by Mark Brindle on 08/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import Foundation
import SwiftUI      // Don't like this dependency on SwiftUI in the controller!.  Needs refactoring.

class CharactersController: ObservableObject {
    @Published public private(set) var characters: [BBCharacter] {
        willSet {
            objectWillChange.send()
        }
    }
    @Published public internal(set) var images: [Int: Image] {
        willSet {
            objectWillChange.send()
        }
    }
    var urlSession = URLSession.shared
    
    private var isLoadingImage = [Int: Bool]()

    internal init(_characters: Published<[BBCharacter]> = Published(initialValue: []), _images: Published<[Int: Image]> = Published(initialValue: [:])) {
        self._characters = _characters
        self._images = _images
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

// Image related functions.  Refactor to UI level to remove dependency on SwiftUI in the controller!!!

extension CharactersController {
    
    func characterImage(for character: BBCharacter, placeHolder: Image) -> Image {
        if let image = images[character.char_id] {
            return image
        } else {
            // Download the image
            DispatchQueue.global().async {
                self.getCharacterImage(for: character)
            }
            // Return the placeholder image
            return placeHolder
        }
    }

    internal func characterImageFolderURL() -> URL {
        let fm = FileManager.default
        let imageDirectoryURL = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("CharacterImages", isDirectory: true)
        return imageDirectoryURL
    }
    
    private func getCharacterImage(for character: BBCharacter) {
        let identifier = character.char_id
        
        // Is this image already being loaded
        if isLoadingImage[identifier] == true { return }
        
        // Is there already an image available for this character?
        if images.keys.contains(identifier) { return }

        // Is the format of the image jpg or png
        let fileType: String
        if character.imageURL.uppercased().contains(".JPG") {
            fileType = ".jpg"
        } else {
            fileType = ".png"
        }

        let fm = FileManager.default
        let folderURL = characterImageFolderURL()
        
        if fm.fileExists(atPath: folderURL.path) == false {
            // Create the character images folder
            do {
                try fm.createDirectory(atPath: folderURL.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Could not create character image folder: \(error.localizedDescription)")
                return
            }
        }
        // Create a filename for saving the image
        let fileURL = folderURL.appendingPathComponent("\(identifier)\(fileType)")
        
        // See if there's already an image downloaded
        if fm.fileExists(atPath: fileURL.path) {
            DispatchQueue.main.async {
                // Use the image
                self.images[identifier] = Image(uiImage: UIImage.init(contentsOfFile: fileURL.path)!)
            }
            return
        }
        
        // No image yet, so download it
        isLoadingImage[identifier] = true
        
        let request = CharacterImageRequest()
        let loader = APIRequestLoader(apiRequest: request)
        loader.loadAPIRequest(requestData: character.imageURL) { (img, error) in
            if let error = error {
                // Handle the error as appropriate.  Here, the error is just printed.
                print("Error loading BB character image: \(error.localizedDescription)")
                self.isLoadingImage[identifier] = false
                return
            } else if let optionalImg = img, let img = optionalImg {
                do {
                    // Save the image ready for use in the app
                    switch fileType {
                    case ".jpg":
                        try img.jpegData(compressionQuality: 1.0)?.write(to: fileURL, options: .atomic)
                    default:
                        try img.pngData()?.write(to: fileURL, options: .atomic)
                    }
                } catch {
                    // Handle the error or make this a throwing func & bubble up
                    print("Error saving file \(fileURL.path) - error: \(error)")
                    self.isLoadingImage[identifier] = false
                    return
                }
                
                DispatchQueue.main.async {
                    // Use the image
                    self.images[identifier] = Image(uiImage: img)
                    self.isLoadingImage[identifier] = false
                }
            }
            
        }
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
