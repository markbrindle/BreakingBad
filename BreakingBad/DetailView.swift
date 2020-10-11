//
//  DetailView.swift
//  BreakingBad
//
//  Created by Mark Brindle on 10/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    @EnvironmentObject var controller: CharactersController
    
    var character: BBCharacter
    
    @State private var flipped = false
    
    let placeholder = Image("HatAndBeard")
    
    var body: some View {
        return Color.init(UIColor.systemBackground)
            .edgesIgnoringSafeArea(.all)
            .overlay (
                ZStack {
                    CharacterView(character: character, placeholder: placeholder)
                        .opacity(self.flipped ? 0 : 1)
                        .animation(.default)
                    CharacterDetailView(character: character)
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 10, z: 0))
                        .opacity(self.flipped ? 1 : 0)
                        .animation(.default)
                }
                .cornerRadius(12)
                .padding()
                .clipped()
                .rotation3DEffect(Angle(degrees: self.flipped ? -180 : 0), axis: (x: 0, y: 10, z: 0))
                .animation(.default)
                .onTapGesture {
                    self.flipped.toggle()
                }
        ).navigationBarTitle(Text("Character card"), displayMode: .inline)
    }
    
}

#if DEBUG
struct DevailView_Previews: PreviewProvider {
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

