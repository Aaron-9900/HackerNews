//
//  RemoteDataSource.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 09/02/2021.
//

import Foundation
import Combine

class RemoteDataSource : DataSource {
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
    func getElementsByIdList(ids: [Int]) -> AnyPublisher<[Story], ItemListError> {
        let itemIds = ids.map { String($0) + ".json"}
        let requests = itemIds.map { id -> AnyPublisher<Story, ItemListError> in
            let url = URL(string: ApiConstants.GET_ITEM_BY_ID + id)!
            return URLSession.shared.dataTaskPublisher(for: url)
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
        return Publishers.MergeMany(requests).collect().eraseToAnyPublisher()
    }
}

