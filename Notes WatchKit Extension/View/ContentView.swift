//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Tin Tran on 11/06/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @AppStorage("lineCount") var lineCount = 1
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""

    // MARK: - FUNCTION
    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Save data has failed!")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {}
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

    // MARK: - BODY
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Note", text: $text)

                Button {
                    guard text.isEmpty == false else { return }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
            } //: HSTACK

            Spacer()
            
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self) {i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                            }
                        } //: HSTACK
                    } //: LOOP
                    .onDelete(perform: delete)
                } //: LIST
                
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }
        } //: VSTACK
        .navigationTitle("Notes")
        .onAppear {
            load()
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
