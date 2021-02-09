//
//  MockRemoteDataSource.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import Foundation
import Combine

class MockRemoteDataSource : DataSource {
    func getTop() -> AnyPublisher<[Int], ItemListError> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: ApiConstants.GET_TOPSTORIES)!)
            .tryMap { response in
                guard
                    let payload = response.response as? HTTPURLResponse, payload.statusCode == 200
                else {
                    throw ItemListError.statusCode
                }
                return response.data
            }
            .decode(type: [Int].self, decoder: JSONDecoder())
            .mapError {
                return ItemListError.map($0)
            }
            .eraseToAnyPublisher()
    }
    func getElementById(id: String) -> AnyPublisher<Story, ItemListError> {
        let item = String(id) + ".json"
        print(ApiConstants.GET_ITEM_BY_ID + item)
        return URLSession.shared.dataTaskPublisher(for: URL(string: ApiConstants.GET_ITEM_BY_ID + item)!)
            .tryMap { response in
                guard
                    let payload = response.response as? HTTPURLResponse, payload.statusCode == 200
                else {
                    throw ItemListError.statusCode
                }
                return response.data
            }
            .decode(type: Story.self, decoder: JSONDecoder())
            .mapError {
                return ItemListError.map($0)
            }
            .eraseToAnyPublisher()
    }
}
