//
//  ContentView.swift
//  iosApp
//
//  Created by objex on 03/05/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundColor(.white)
            Button(action: {
                print("clicked")
            }, label: {
                Text("Increment AI Counter")
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
