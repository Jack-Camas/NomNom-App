//
//  ContentView.swift
//  Camera
//
//  Created by Life on 3/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var extractedText = [String]()

    var body: some View {
        List(extractedText, id: \.self) { text in
            Text(text)
        }
        .onLongPressGesture {
            // Allow the user to select a specific area of text
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
