//
//  CommentsDataSource.swift
//  HackerNews
//
//  Created by Aaron Hoffman on 13/03/2021.
//

import Foundation
import Combine

extension RemoteDataSource {
    func getComments(ids: [Int]) -> AnyPublisher<[Comment], ItemListError> {
        let itemIds = ids.map { String($0) + ".json"}
        let requests = itemIds.map { id -> AnyPublisher<Comment, ItemListError> in
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
                .decode(type: Comment.self, decoder: JSONDecoder())
                .mapError {
                    return ItemListError.map($0)
                }
                .eraseToAnyPublisher()
        }
        return Publishers.MergeMany(requests).collect().eraseToAnyPublisher()
    }
}
