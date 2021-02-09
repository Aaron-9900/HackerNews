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
}

extension Story : Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case by
        case title
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.url = try values.decode(String.self, forKey: .url)
        } catch {
            self.url = ""
        }
        self.id = try values.decode(Int.self, forKey: .id)
        self.by = try values.decode(String.self, forKey: .by)
        self.title = try values.decode(String.self, forKey: .title)
        
    }
}
