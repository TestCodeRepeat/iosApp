//
//  ContentView.swift
//  iosApp
//
//  Created by objex on 03/05/2024.
//

import SwiftUI
import shared

struct ContentView: View {

    var repository = AiCounterRepository()
    @State private var message: String = "Hello, world!"

    func activate() async {
        for await aMessage in repository.messageFlow {
            self.message = aMessage
        }
    }

    init() {

    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("self.message = \(message)")
                .foregroundColor(.white)
            Button(action: {
                print("clicked")
                print(repository.hello())
            }, label: {
                Text("Increment AI Counter")
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .task {
            await activate()
        }
    }
}

#Preview {
    ContentView()
}
