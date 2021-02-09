//
//  DataSource.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import Foundation
import Combine

protocol DataSource {
    func getTop() -> AnyPublisher<[Int], ItemListError>
    func getElementById(id: String) -> AnyPublisher<Story, ItemListError>
    func getElementsByIdList(ids: [Int]) -> AnyPublisher<[Story], ItemListError>
}
