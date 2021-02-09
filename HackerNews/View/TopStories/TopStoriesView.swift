//
//  ContentView.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import SwiftUI

struct TopStoriesState {
    var topIds: [Int]
    var start: Int
    var end: Int
    var items: [Story]
    var service: DataSource
}
enum TopStoriesInput {
    case endReached
}

struct TopStoriesView: View {
    @ObservedObject var viewModel: AnyViewModel<TopStoriesState, TopStoriesInput>
    init() {
        viewModel = AnyViewModel(TopStoriesViewModel(service: RemoteDataSource()))
    }
    var body: some View {
        Text("Top stories")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        List {
            ForEach(viewModel.items, id: \.self.id) {
                TopStoryRow(story: $0)
            }
            Text("")
                .onAppear(perform: {
                    loadMore()
                })
        }
    }
}

extension TopStoriesView {
    func loadMore() {
        viewModel.trigger(.endReached)
    }
}
