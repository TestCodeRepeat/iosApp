//
//  MainViewModel.swift
//  iosApp
//
//  Created by objex on 06/05/2024.
//

import Foundation
import Combine
import shared

    class MainViewModel: ObservableObject {
        
        let store = AiCounterStore()
        
        @Published var state:AiCounterState
        private var cancellables: Set<AnyCancellable> = []

        init() {
            self.state = store.iosState.value
            activate()
        }

        func activate()  {
            Task {
                for await it in store.iosState {
                    self.state = it
                }
            }
        }

        func hello(){
            print("SwiftUI.hello()")
            let response = store.dispatch(action: AiCounterAction.PostMessage(message: "hello"))
            print("res: \(response)")
        }
        
        func incrementCounter() {
            store.dispatch(action: AiCounterAction.Increment())
        }
    }
