//
//  ParameterEncoding.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation

public typealias Parameters = [String: Any]
protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

