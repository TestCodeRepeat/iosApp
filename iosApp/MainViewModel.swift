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
        Task{
            do {
                for await it in try eventBus.getStoreSideEffectEvents(){
                    self.handleEventfromEventBus(it.action)
                }
            } catch let error as NSError {
                print("Caught Kotlin exception: \(error)")
            }
        }
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
    
    func sendEvent(event: Event){
        func sendAnEvent(event: Event) async {
            do {
                try await eventBus.sendEvent(event: event)
            } catch {
                print("Error sending event: \(error)")
            }
        }
    }
    
    func handleEventfromEventBus(_ action:Effect) {
        switch action {
        case let storeSideEffect as AiCounterEffect.ShowToast:
            print("AiCounter Store Side Effect Triggered: \(storeSideEffect.message)")
            
        default:
            print("Unhandled Event Type: \(action)")
        }
    }
}
