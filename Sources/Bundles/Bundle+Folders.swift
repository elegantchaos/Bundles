// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 13/09/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public extension Bundle {
    /// Return a URL for the application support directory for this bundle/application
    /// The bundle is assumed to have a bundle identifier, which is used to name the
    /// directory. If necessary, the directory is created.
    var applicationSupportURL: URL {
        let fm = FileManager.default
        let baseURL = try! fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let supportURL = baseURL.appendingPathComponent(bundleIdentifier!)
        try? fm.createDirectory(at: supportURL, withIntermediateDirectories: true, attributes: nil)
        return supportURL
    }
}
