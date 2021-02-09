//
//  TopStoryRow.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import SwiftUI

struct TopStoryRow: View {
    let story: Story
    init(story: Story) {
        self.story = story
    }
    var body: some View {
        VStack {
            Text(self.story.title)
                .font(.title2)
                .padding(20)
            Spacer()
            Text(self.story.url)
                .font(.caption)
        }
    }
}
