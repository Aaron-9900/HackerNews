//
//  TopStoryRow.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import SwiftUI

struct TopStoryRow: View {
    let story: Story
    let index: Int
    init(story: Story, index: Int) {
        self.story = story
        self.index = index
    }
    var body: some View {
        VStack {
            if index == 0 {
                Divider()
            }
            NavigationLink(destination: StoryDetailView(story: story)) {
                Text(self.story.title)
                    .font(.title3)
                    .padding(10)
                    .foregroundColor(.black)
                    .layoutPriority(2)
            }
            if !self.story.url.isEmpty {
                Spacer()
                UnnamedLink(url: self.story.url)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.orange)
            }
           
        }
        .padding()
        .frame(alignment: .center)
        Divider()
        
    }
}

