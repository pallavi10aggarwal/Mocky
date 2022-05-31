//
//  RemoteAPIResponseHandler.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation

protocol RemoteAPIResponseHandler {
    func handleNetworkResponse(_ response: URLResponse?, data: Data?) -> Result<Void, Error>
}

