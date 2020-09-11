//
//  MasterView.swift
//  BreakingBad
//
//  Created by Mark Brindle on 10/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import SwiftUI

struct MasterView: View {
    @EnvironmentObject var controller: CharactersController
    @Binding var selectedCharacterId: String?
    
    // Filtering
    @State private var filter: String = ""
    @State private var season: Int? = nil
    
    private let placeholder = Image.init("BB-Placeholder")
    
    var body: some View {
        let filteredCharacters = controller.filteredCharacters(with: filter, season: season)
        return VStack(alignment:.leading, spacing: 8) {
            Text("Season filter")
                .font(.title)
                .padding([.leading])
            ScrollView(.horizontal) {
                HStack {
                    filterButton(label: "All")
                    filterButton(label: "Season 1")
                    filterButton(label: "Season 2")
                    filterButton(label: "Season 3")
                    filterButton(label: "Season 4")
                    filterButton(label: "Season 5")
                }
            }.padding([.leading, .trailing])
            SearchBar(text: $filter)
            List(filteredCharacters, id: \.self) { character in
                NavigationLink(destination: DetailView(selectedCharacterId: self.$selectedCharacterId),
                               tag: "\(character.char_id)", selection: self.$selectedCharacterId ) {
                                HStack {
                                    self.controller.characterImage(for: character, placeholder: self.placeholder)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44, alignment: .center)
                                        .cornerRadius(6)
                                    Text(character.name)
                                }
                }.onTapGesture {
                    self.selectedCharacterId = "\(character.char_id)"
                }
            }
        }
    }
    
    fileprivate func filterButton(label: String) -> some View {
        return Button(label) {
            self.season = Int(String(label.last!))
        }
        .padding(6)
        .frame(minWidth: 44)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

#if DEBUG
struct MasterView_Previews: PreviewProvider {
    static let characters = [
         BBCharacter(char_id: 1, name: "Walter White", birthday: "01 01 1970", occupations: ["High School Chemistry Teacher", "Meth King Pin"], status: "Presumed dead", nickname: "Heisenberg", imageURL: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg", appearances: [1,2,3,4,5] ),

         BBCharacter(char_id: 2, name: "Jesse Pinkman", birthday: "09-24-1984", occupations: ["Meth Dealer"], status: "Alive", nickname: "Cap n' Cook", imageURL: "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Jesse_Pinkman2.jpg/220px-Jesse_Pinkman2.jpg", appearances: [1, 2, 3, 4, 5] ),

         BBCharacter(char_id: 11, name: "Domingo Molina", birthday: "Unknown", occupations: ["Meth Distributor"], status: "Deceased", nickname: "Krazy-8", imageURL: "https://vignette.wikia.nocookie.net/breakingbad/images/e/e7/Krazy8.png/revision/latest?cb=20130208041554", appearances: [1] ),
     ]
    
    static var previews: some View {
        Group {
            NavigationView {
                MasterView(selectedCharacterId: .mock("0"))
            }.environmentObject(CharactersController(_characters: Published(initialValue: characters)))
            NavigationView {
                MasterView(selectedCharacterId: .mock("0"))
                    .environment(\.colorScheme, .dark)
            }.environmentObject(CharactersController(_characters: Published(initialValue: characters)))
        }
    }
}
#endif
