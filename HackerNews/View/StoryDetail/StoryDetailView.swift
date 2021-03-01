//
//  StoryDetailView.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 01/03/2021.
//

import SwiftUI

struct StoryDetailView : View {
    let story: Story
    var body: some View {
        ScrollView {
            VStack {
                Text(story.title)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(2)
                UnnamedLink(url: story.url)
                Text("By: " + story.by)
                    .font(.footnote)
            }
            .frame(alignment: .leading)
            .padding()
        }

    }
}

struct StoryDetailViewPreview : PreviewProvider {
    static var previews: some View {
       StoryDetailView(story: Story(id: 0, by: "Test user", title: "Test title", url: "http://www.google.com", kids: []))
    }
    
}
