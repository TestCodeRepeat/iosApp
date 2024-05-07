//
//  CounterScreen.swift
//  iosApp
//
//  Created by objex on 07/05/2024.
//

import Foundation

import SwiftUI
import shared

struct CounterScreen: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack {
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
                            print("Increment w/ OnComplete")
                        }))
            }, label: {
                Text("Increment w/ OnComplete")
            })
            .padding(.vertical, 20)

            Button(action: {
                viewModel.counterStore.dispatch(action: AiCounterAction.PostMessage(message: "PostMessage - hello clicked"))
            }, label: {
                Text("Hello World")
            })
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
