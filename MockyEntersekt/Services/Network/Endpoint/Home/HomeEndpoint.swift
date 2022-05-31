//
//  HomeEndpoint.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation


import Combine
import Foundation

enum HomeEndpoint: EndPointType {
    case getMockyList
}

extension HomeEndpoint {
    var environmentBaseURL: String { Config.baseEndPoint }
   

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("failed to configure base URL")
        }
        return url
    }

//    var path: String {
//        switch self {
//        case .getMarvelList:
//            return paths
//        case .getMockyList:
//             return ""
//        }
//    }

    var httpMethod: HTTPMethod {
        switch self {
        case  .getMockyList:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getMockyList:
            return .requestParameters(bodyParameters: nil,urlParameters: nil)
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .getMockyList:
            return ["Content-Type": "application/json"]
        }
    }
}
