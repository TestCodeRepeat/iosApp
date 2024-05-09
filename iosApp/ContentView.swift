//
//  ContentView.swift
//  iosApp
//
//  Created by objex on 03/05/2024.
//

import SwiftUI
import shared

enum Screen {
    case counter
    case todos
}

struct ContentView: View {

    @StateObject private var viewModel = MainViewModel()
    @SwiftUI.State private var currentScreen: Screen = .counter
    
    init() {

    }

    var body: some View {
        VStack {
            Text("Ai Counter Screen")
                .foregroundColor(.white)
                .padding(.vertical, 20)
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("state.message = \(viewModel.counterState.message)")
                .foregroundColor(.white)
                .padding(.vertical, 20)

            Text("state.count = \(viewModel.counterState.count)")
                .foregroundColor(.white)
                .padding(.vertical, 20)

            Button(action: {
                viewModel.counterStore.dispatch(action: AiCounterAction.Increment())
            }, label: {
                Text("Increment AI Counter")
            })
            .padding(.vertical, 20)

            Button(action: {
                viewModel.counterStore.dispatch(
                    action: AiCounterAction.IncrementWithOnComplete(
                        message: "Increment OnComplete",
                        onComplete: {
                            onComplete()
                        }))
            }, label: {
                Text("Increment w/ OnComplete")
            })
            .padding(.vertical, 20)

            Button(action: {
                viewModel.counterStore.dispatch(action: AiCounterAction.PostMessage(message: "PostMessage - Hello World clicked"))
            }, label: {
                Text("Hello World")
            })
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }

    func onComplete(){
        print("ContentView.onComplete() called")
    }
}

#Preview {
    ContentView()
}
