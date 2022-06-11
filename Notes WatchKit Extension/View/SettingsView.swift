//
//  Settings.swift
//  Notes WatchKit Extension
//
//  Created by Tin Tran on 11/06/2022.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTY
    @AppStorage("lineCount") var lineCount = 1
    @State private var value: Float = 1.0
    
    // MARK: - FUNCTION
    func update() {
        lineCount = Int(value)
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 8) {
            // MARK: - HEADER
            HeaderView(title: "Settings")
            // MARK: - ACTUAL LINE COUNT
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            // MARK: - SLIDER
            Slider(value: Binding(get: {
                self.value
            }, set: {(newValue) in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
        } //: VSTACK
    }
}

// MARK: - PREVIEW
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
