//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Tin Tran on 11/06/2022.
//

import SwiftUI

struct DetailView: View {
    // MARK: - PROPERTY
    let note: Note
    let count: Int
    let index: Int
    
    @State private var isCreditsPresented = false
    @State private var isSettingsPresented = false
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            // MARK: - header
           HeaderView()
            
            Spacer()
            // MARK: - content
            ScrollView(.vertical, showsIndicators: false) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            // MARK: - footer
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented, content: {
                        SettingsView()
                    })
                    
                Spacer()
                Text("\(count) / \(index+1)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditsPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditsPresented, content: {
                        CreditsView()
                    })
            }
            .foregroundColor(.secondary)
        } //: VSTACK
        .padding(3)
    }
}

// MARK: - PREVIEW
struct DetailView_Previews: PreviewProvider {
    static var sampleNote = Note(id: UUID(), text: "Awesome note.")
    
    static var previews: some View {
        DetailView(note: sampleNote, count: 5, index: 1)
    }
}
