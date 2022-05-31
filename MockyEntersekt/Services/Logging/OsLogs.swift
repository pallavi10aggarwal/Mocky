//
//  OsLogs.swift
//  MockyEntersekt
//
//  Created by Pallavi Aggarwal on 5/26/22.
//

import Foundation
import os.log

enum LogCategory: String {
    case network = "[Network]"
}

extension OSLog {
    private static var subsystem: String { Bundle.main.bundleIdentifier ?? "" }

    // MARK: Logs

    static let network = OSLog(subsystem: subsystem, category: LogCategory.network.rawValue)
}

