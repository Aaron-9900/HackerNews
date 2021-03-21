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
                VirtualList(items: viewModel.items, view: {(item, index) in
                    TopStoryRow(story: item, index: index)
                }, callback: {
                    loadMore()
                }, spinner: setSpinner)
            }
            .navigationTitle("Top Stories")
        }
        .accentColor(.orange)
            
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
