//
//  SearchBar.swift
//  BreakingBad
//
//  Created by Mark Brindle on 10/09/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//

import SwiftUI
import UIKit

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            tidyUp(searchBar)
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        private func tidyUp(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(text: $text) }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search characters by name"
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}

#if DEBUG && targetEnvironment(simulator)
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .mock("Breaking Bad!"))
            .previewAsComponent()
    }
}
#endif
