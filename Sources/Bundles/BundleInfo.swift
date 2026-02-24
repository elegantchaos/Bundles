// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/02/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Coercion
import Foundation
import Images
import SemanticVersion

public struct BundleInfo {
    public let name: String
    public let id: String
    public let executable: String
        
    public let build: Int
    public let version: SemanticVersion
    public let commit: String
    public let copyright: String
    
    public var versionString: String { return version.asString }
    public var fullVersionString: String { return "\(version.asString) (\(build))" }
        
    public init(for bundle: Bundle = Bundle.main) {
        id = bundle.bundleIdentifier!
        let info = bundle.infoDictionary!
        name = info[asString: "CFBundleName"] ?? ""

        executable = info[asString: "CFBundleExecutable"] ?? ""
        build = info[asInt: "CFBundleVersion"] ?? 0
        version = SemanticVersion(info[asString:"CFBundleShortVersionString"])
        commit = info[asString: "Commit"] ?? ""
        copyright = info[asString: "NSHumanReadableCopyright"] ?? ""
    }
    
    public init(name: String, id: String, executable: String = "", icon: Image = Image(), build: Int, version: SemanticVersion, commit: String = "", copyright: String = "") {
        self.name = name
        self.id = id
        self.executable = executable
        self.build = build
        self.version = version
        self.commit = commit
        self.copyright = copyright
    }
}
