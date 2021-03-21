//
//  StoryDetailViewModel.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 13/03/2021.
//

import Foundation
import Combine

struct StoryDetailState {
    var commentIds: [Int]
    var start: Int
    var end: Int
    var items: [Comment]
    var service: DataSource
    var status: LoadingStatus
}
enum CommentsInput {
    case endReached
    case load
}

class StoryDetailViewModel: ViewModel {
    var subscriptions: Set<AnyCancellable> = []
    @Published var state: StoryDetailState
    
    init(service: DataSource, comments: [Int]?) {
        state = StoryDetailState(commentIds: comments ?? [], start:0, end: 10, items: [], service: service, status: .loading)
        trigger(.load)
    }
    func getElementsToIndex() {
        if state.commentIds.at(index: state.end) == nil {
            state.end = state.commentIds.count
        }
        guard state.start < state.end else {
            return
        }
        self.state.status = .loading
        state.service.getComments(ids: Array(state.commentIds[state.start..<state.end]))
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
                print(self.state.items)
            })
            .store(in: &subscriptions)
    }
    
    func trigger(_ input: CommentsInput) {
        switch input {
        case .endReached:
            if state.items.count > 0 {
                state.start = state.end + 1
                state.end = state.end + 10
                getElementsToIndex()
            }
        case .load:
            getElementsToIndex()
        }

    }
}
