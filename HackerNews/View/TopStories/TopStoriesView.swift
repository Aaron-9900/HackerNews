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
    var status: LoadingStatus
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
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.items.enumerated()), id: \.1.id) { (index, item) in
                        TopStoryRow(story: item, index: index)
                    }
                    Text("")
                        .listRowInsets(EdgeInsets(top: -20, leading: -20, bottom: -20, trailing: -20))
                        .onAppear(perform: {
                            loadMore()
                        })
                    setSpinner()
                }
            }.navigationTitle("Top Stories")
        }
       
    }
}

extension TopStoriesView {
    func loadMore() {
        viewModel.trigger(.endReached)
    }
    func setSpinner() -> AnyView {
        switch viewModel.status {
        case .loading:
            return AnyView(ProgressView()
                .progressViewStyle(CircularProgressViewStyle()))
        default:
            return AnyView(Text(""))
        
        }
    }
}
