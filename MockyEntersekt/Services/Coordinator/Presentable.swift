//
//  Presentable.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import UIKit

protocol Presentable {
    func toPresentable() -> UIViewController
}

extension UIViewController: Presentable {
    func toPresentable() -> UIViewController { self }
}

