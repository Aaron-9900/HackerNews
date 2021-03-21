//
//  CommentDetail.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 13/03/2021.
//

import SwiftUI

struct CommentDetail: View {
    let comment: Comment
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(comment.by)
                    .font(.footnote)
                Text(comment.getBody())
                    .font(.body)
                    .padding(.vertical, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Divider()
            }
            Spacer()
        }

    }
}

