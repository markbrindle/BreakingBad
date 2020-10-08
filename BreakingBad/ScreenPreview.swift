//
//  ScreenPreview.swift
//  BreakingBad
//
//  Created by Mark Brindle on 08/10/2020.
//  Copyright © 2020 ARKEMM Software Limited. All rights reserved.
//
// Attribution: https://www.swiftbysundell.com/articles/getting-the-most-out-of-xcode-previews/

import SwiftUI

#if DEBUG && targetEnvironment(simulator)

struct ScreenPreview<Screen: View>: View {
    var screen: Screen
    
    var body: some View {
        ForEach(values: deviceNames) { device in
            ForEach(values: ColorScheme.allCases) { scheme in
                NavigationView {
                    self.screen
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
            .previewDevice(PreviewDevice(rawValue: device))
            .colorScheme(scheme)
                .previewDisplayName("\(scheme.previewName): \(device)")
            .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
    
    private var deviceNames: [String] {
        [
            "iPhone SE (2nd generation)",
            "iPhone 8",
            "iPhone X",
            "iPhone 11",
            "iPhone 11 Pro Max",
            "iPad (7th generation)",
            "iPad Pro (12.9-inch) (4th generation)",
        ]
    }
}

struct ScreenPreview_Previews: PreviewProvider {
    static var previews: some View {
        ScreenPreview(screen: Text("Hello World"))
    }
}

struct ComponentPreview<Component: View>: View {
    var component: Component
    
    var body: some View {
        ForEach(values: ColorScheme.allCases) { scheme in
            ForEach(values: ContentSizeCategory.smallestAndLargest) { category in
                self.component
                    .previewLayout(.sizeThatFits)
                    .background(Color(UIColor.systemBackground))
                    .colorScheme(scheme)
                    .environment(\.sizeCategory, category)
                    .previewDisplayName("\(scheme.previewName) + \(category.previewName)")
            }
        }
    }
}

extension View {
    func previewAsScreen() -> some View {
        ScreenPreview(screen: self)
    }
    
    func previewAsComponent() -> some View {
        ComponentPreview(component: self)
    }
}

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}

extension ColorScheme {
    var previewName: String {
        String(describing: self).capitalized
    }
}

extension ContentSizeCategory {
    static let smallestAndLargest = [allCases.first!, allCases.last!]
    
    var previewName: String {
        self == Self.smallestAndLargest.first ? "Small" : "Large"
    }
}

#endif
