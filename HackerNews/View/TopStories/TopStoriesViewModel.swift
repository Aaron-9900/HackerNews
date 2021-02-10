//
//  TopStoriesViewModel.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import Foundation
import Combine

class TopStoriesViewModel: ViewModel {
    var subscriptions: Set<AnyCancellable> = []
    @Published var state: TopStoriesState
    
    init(service: DataSource) {
        state = TopStoriesState(topIds: [], start:0, end: 10, items: [], service: service, status: .loading)
        getTopIds()
    }
    func getElementsToIndex() {
        if state.topIds.at(index: state.end) == nil {
            state.end = state.topIds.count
        }
        guard state.start < state.end else {
            return
        }
        self.state.status = .loading
        state.service.getElementsByIdList(ids: Array(state.topIds[state.start...state.end]))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error) :
                    print("Error:", error)
                    self.state.status = .error
                }
                
            }, receiveValue: { [unowned self] response in
                self.state.status = .idle
                self.state.items.append(contentsOf: response)
            })
            .store(in: &subscriptions)
    }
    func getTopIds() {
        state.service.getTop()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error) :
                    print("Error:", error)
                    self.state.status = .error
                }
                
            }, receiveValue: { [unowned self] response in
                self.state.topIds = Array(response[0...100])
                self.state.status = .idle
                getElementsToIndex()
            })
            .store(in: &subscriptions)
    }
    
    func trigger(_ input: TopStoriesInput) {
        switch input {
        case .endReached:
            if state.items.count > 0 {
                state.start = state.end + 1
                state.end = state.end + 10
                getElementsToIndex()
            }
        }
    }
}
