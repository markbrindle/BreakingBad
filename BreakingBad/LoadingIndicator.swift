//
//  LoadingIndicator.swift
//  BreakingBad
//
//  Created by Mark Brindle on 11/10/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//
// Attribution: https://medium.com/@tianna_lewis05/cracking-swiftui-implementing-uiactivityindicator-3e1402d5677f

import SwiftUI

struct LoadingIndicator: UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> LoadingIndicator.UIViewType {
        UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingIndicator>) {
        uiView.startAnimating()
    }
}

struct LoadingIndicatorView<Content>: View where Content: View {
    
    var isDisplayed: Bool
    
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if isDisplayed {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)
                    
                    VStack {
                        Text("Say my name")
                        LoadingIndicator(style: .large)
                    }
                    .frame(width: geometry.size.width * 0.75, height: 200.0)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color("Baize"))
                    .cornerRadius(20)
                } else {
                    self.content()
                }
            }
        }
    }
}
