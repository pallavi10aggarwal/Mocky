//
//  HomeRemoteAPI.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Combine
import Foundation

protocol HomeRemoteAPI {
    func getMockyList() -> AnyPublisher<MockyResponse, NetworkError>
}

struct HomeAPI: HomeRemoteAPI {
    private let homeRouter: APIRouter<HomeEndpoint>
    private let homeResponseHandler: RemoteAPIResponseHandler

    init(homeRouter: APIRouter<HomeEndpoint>,
         homeResponseHandler: RemoteAPIResponseHandler) {
        self.homeRouter = homeRouter
        self.homeResponseHandler = homeResponseHandler
    }
    func getMockyList() -> AnyPublisher<MockyResponse, NetworkError> {
        return homeRouter
            .request(.getMockyList,
                     responseHandler: homeResponseHandler)
    }
}

