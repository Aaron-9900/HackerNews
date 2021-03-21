//
//  StoryDetailView.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 01/03/2021.
//

import SwiftUI

struct StoryDetailView : View {
    let story: Story
    @ObservedObject var viewModel: AnyViewModel<StoryDetailState, CommentsInput>
    init(story: Story) {
        self.story = story
        viewModel = AnyViewModel(StoryDetailViewModel(service: RemoteDataSource(), comments: story.kids))
    }
    var body: some View {
        ScrollView {
            VStack {
                self.body(story: story)
                VirtualList(items: viewModel.items, view: {(item, index) in
                    CommentDetail(comment: item)
                }, callback: {
                    loadMore()
                }, spinner: setSpinner)
            }
            .padding()
        }
    }
    private func body(story: Story) -> some View {
        VStack {
            Text(story.title)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(2)
            UnnamedLink(url: story.url)
                .foregroundColor(.orange)
            Text("By: " + story.by)
                .font(.footnote)
            Divider()
        }
    }
    
}

extension StoryDetailView {
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

