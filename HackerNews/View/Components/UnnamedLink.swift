//
//  UnnamedLink.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 01/03/2021.
//

import SwiftUI

struct UnnamedLink : View {
    let url: String
    var body: some View {
        Link(url, destination: getUrl(url))
            .font(.caption)
    }
}
