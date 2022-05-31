//
//  WindowRouter.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import UIKit

protocol WindowRouterType: AnyObject {
    var window: UIWindow { get }
    init(window: UIWindow)
    func setRootModule(_ module: Presentable)
}

final class WindowRouter: NSObject, WindowRouterType {
    unowned let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    func setRootModule(_ module: Presentable) {
        let viewController = module.toPresentable()
        window.rootViewController = viewController
    }
}
