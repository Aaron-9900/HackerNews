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
    @State private var pressed = false
    init(story: Story, index: Int) {
        self.story = story
        self.index = index
    }
    var body: some View {
        VStack {
            if index == 0 {
                Divider()
            }
            Text(self.story.title)
                .font(.title2)
                .padding(10)
            Spacer()
            if !self.story.url.isEmpty {
                Link(self.story.url, destination: getUrl(self.story.url))
                    .foregroundColor(.black)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
           
        }
        .padding()
        .frame(height: 100, alignment: .center)
        /*
        .opacity(pressed ? 0.6 : 1)
        .onTapGesture {}
        .onLongPressGesture(pressing: { pressing in
            self.pressed = pressing
        }, perform: {
            let url = URL(string: self.story.url)
            guard let finalUrl = url, UIApplication.shared.canOpenURL(finalUrl) else { return }
            UIApplication.shared.open(finalUrl)
        })*/
        Divider()
        
    }
}

extension TopStoryRow {
    private func getUrl(_ url: String) -> URL{
        guard let safeUrl = URL(string: url) else {
            return URL(string: "-")!
        }
        return safeUrl
    }
}
