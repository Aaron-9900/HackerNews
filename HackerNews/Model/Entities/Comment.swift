//
//  Comment.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 13/03/2021.
//

import Foundation
import SwiftSoup

struct Comment : Identifiable, Decodable {
    let id: Int
    let by: String
    let kids: [Int]?
    let parent: Int?
    let text: String
}

extension Comment {
    func getBody() -> String {
        do {
            return try SwiftSoup.parse(self.text).text()
        } catch {
            return self.text
        }
    }
}
