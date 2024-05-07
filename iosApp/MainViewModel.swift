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
    
    let eventBus:EventBus
    let counterStore:AiCounterStore
    let todoStore:AiTodoStore
    
    @Published var counterState: AiCounterState
    @Published var todoState: AiTodoState
    
    init() {
        self.eventBus = EventBusImpl()
        self.counterStore = AiCounterStore(eventBus: self.eventBus)
        self.todoStore = AiTodoStore(eventBus: self.eventBus)
        self.counterState = counterStore.iosState.value
        self.todoState = todoStore.iosState.value
        startObservingState()
    }
    
    func startObservingState() {
        Task {
            for await it in counterStore.iosState {
                DispatchQueue.main.async {
                    self.counterState = it
                }
            }
        }
        Task {
            for await it in todoStore.iosState {
                DispatchQueue.main.async {
                    self.todoState = it
                }
            }
        }
    }
}
