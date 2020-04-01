// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import CollectionExtensions
import Foundation
import Images
import SemanticVersion

public struct BundleInfo {
    public let name: String
    public let id: String
    public let executable: String
    
    #if canImport(UIKit) || canImport(AppKit)
    public let icon: Image
    #endif
    
    public let build: Int
    public let version: SemanticVersion
    public let commit: String
    public let copyright: String
    
    public var versionString: String { return version.asString }
    public var fullVersionString: String { return "\(version.asString) (\(build))" }
        
    init(for bundle: Bundle = Bundle.main) {
        id = bundle.bundleIdentifier!
        let info = bundle.infoDictionary!
        name = info[stringWithKey: "CFBundleName"] ?? ""

        #if canImport(UIKit) || canImport(AppKit)
        icon = Image.imageOrBlank(named: info[stringWithKey: "CFBundleIconName"])
        #endif
        
        executable = info[stringWithKey: "CFBundleExecutable"] ?? ""
        build = info[intWithKey: "CFBundleVersion"] ?? 0
        version = SemanticVersion(info[stringWithKey:"CFBundleShortVersionString"])
        commit = info[stringWithKey: "Commit"] ?? ""
        copyright = info[stringWithKey: "NSHumanReadableCopyright"] ?? ""
    }
}
