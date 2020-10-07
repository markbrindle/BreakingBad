//
//  CharacterDetailView.swift
//  BreakingBad
//
//  Created by Mark Brindle on 11/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import SwiftUI

struct CharacterDetailView: View {
    var character: BBCharacter
    
    var body: some View {
        Color.init("CardBack")
            .overlay(
                VStack {
                    Text(character.name)
                        .font(.largeTitle)
                    Text("Occupations: \(character.occupations.description)")
                    VStack {
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("\t\(occupation)")
                        }
                    }
                    Text("Nickname: \(character.nickname)")
                    Text("Status: \(character.status)")
                }
        )
    }
}

#if DEBUG
struct CharacterDetailView_Previews: PreviewProvider {
    static let characters = [
        BBCharacter(char_id: 1, name: "Walter White", birthday: "01 01 1970", occupations: ["High School Chemistry Teacher", "Meth King Pin"], status: "Presumed dead", nickname: "Heisenberg", imageURL: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg", appearances: [1,2,3,4,5] ),
        
        BBCharacter(char_id: 2, name: "Jesse Pinkman", birthday: "09-24-1984", occupations: ["Meth Dealer"], status: "Alive", nickname: "Cap n' Cook", imageURL: "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Jesse_Pinkman2.jpg/220px-Jesse_Pinkman2.jpg", appearances: [1, 2, 3, 4, 5] ),
        
        BBCharacter(char_id: 11, name: "Domingo Molina", birthday: "Unknown", occupations: ["Meth Distributor"], status: "Deceased", nickname: "Krazy-8", imageURL: "https://vignette.wikia.nocookie.net/breakingbad/images/e/e7/Krazy8.png/revision/latest?cb=20130208041554", appearances: [1] ),
    ]
    
    static var previews: some View {
        Group {
            NavigationView {
                MasterView(selectedCharacterId: .mock("11"))
            }.environmentObject(CharactersController(_characters: Published(initialValue: characters)))
            NavigationView {
                MasterView(selectedCharacterId: .mock("2"))
                    .environment(\.colorScheme, .dark)
            }.environmentObject(CharactersController(_characters: Published(initialValue: characters)))
        }
    }
}
#endif