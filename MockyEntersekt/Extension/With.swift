//
//  With.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation

public func with<T: AnyObject>(_ item: T, update: (T) -> Void) -> T {
    update(item); return item
}

