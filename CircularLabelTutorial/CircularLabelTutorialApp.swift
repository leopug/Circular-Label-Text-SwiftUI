//
//  CircularLabelTutorialApp.swift
//  CircularLabelTutorial
//
//  Created by Leonardo Maia Pugliese on 09/05/2023.
//

import SwiftUI

@main
struct CircularLabelTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            CircularTextView(title: "Let's learn SwiftUI! The most magical Framework.".uppercased(), radius: 125)
        }
    }
}
