//
//  ApiConstants.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import Foundation

struct ApiConstants {
    static let VERSION = "v0/"
    static let BASE_URL = "https://hacker-news.firebaseio.com/" + VERSION
    static let GET_TOPSTORIES = BASE_URL + "topstories.json"
    static let GET_ITEM_BY_ID = BASE_URL + "item/"
}
