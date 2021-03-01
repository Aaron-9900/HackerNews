//
//  Story.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import Foundation

struct Story : Identifiable {
    let id: Int
    let by: String
    let title: String
    let url: String
    let kids: [Int]?
}

extension Story : Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case by
        case title
        case kids
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.url = try values.decode(String.self, forKey: .url)
        } catch {
            self.url = ""
        }
        self.by = try values.decode(String.self, forKey: .by)
        self.kids = try values.decodeIfPresent([Int].self, forKey: .kids)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
    }
}
