//
//  View+GetUrl.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 01/03/2021.
//

import SwiftUI

extension View {
    func getUrl(_ url: String) -> URL{
        guard let safeUrl = URL(string: url) else {
            return URL(string: "-")!
        }
        return safeUrl
    }
}
