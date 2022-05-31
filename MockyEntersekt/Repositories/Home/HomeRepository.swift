//
//  HomeRepository.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Combine
import Foundation

protocol HomeRepository {
func mockyList()->AnyPublisher<MockyResponse, NetworkError>
}

class HomeRepo: HomeRepository {
    let homeAPI: HomeRemoteAPI

    private var subscriptions = Set<AnyCancellable>()

    init(homeAPI: HomeRemoteAPI) {
        self.homeAPI = homeAPI
    }
    func mockyList() -> AnyPublisher<MockyResponse, NetworkError> {
        let homeAPI = homeAPI
        return homeAPI.getMockyList()
    }
}

