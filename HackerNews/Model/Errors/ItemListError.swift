//
//  ItemListError.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import Foundation

enum ItemListError : Error {
    case statusCode
    case decoding
    case other(Error)
    static func map(_ error: Error) -> ItemListError {
        return (error as? ItemListError) ?? .other(error)
    }
}
