//
//  HomeAPIResponseHandler.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation

class HomeAPIResponseHandler: RemoteAPIResponseHandler {
    func handleNetworkResponse(_ response: URLResponse?, data: Data?) -> Result<Void, Error> {
        guard let response = response as? HTTPURLResponse else { return .failure(NetworkError.unknown) }

        switch response.statusCode {
        case 200 ... 299:
            return .success(())
        case 400:
            return .failure(NetworkError.badRequest(code: response.statusCode, error: "Bad request"))
        case 401:
            return .failure(NetworkError.unauthorized(code: response.statusCode, error: "Unauthorized"))
        case 501 ... 599:
            return .failure(NetworkError.serverError(code: response.statusCode, error: "Internal server error occured"))
        default:
            return .failure(NetworkError.unknown)
        }
    }
}
