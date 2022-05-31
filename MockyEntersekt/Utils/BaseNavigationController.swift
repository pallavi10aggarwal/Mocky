//
//  BaseNavigationController.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    // Return the visible child view controller which determines the status bar style.
    override var childForStatusBarStyle: UIViewController? { return visibleViewController }
}

