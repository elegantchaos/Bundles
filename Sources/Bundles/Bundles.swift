// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 21/01/20.
//  All code (c) 2020 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Files
import Foundation

/// Resource decoding utilities.
/// These methods are intended for situations where you can guarantee the resource is present in the bundle, so they
/// throw fatal errors if anything goes wrong.

public extension Bundle {
    func stringResource(named name: String, withExtension ext: String = "string", subdirectory: String? = nil) -> String {
        guard let url = url(forResource: name, withExtension: ext, subdirectory: subdirectory) else {
            fatalError("Missing string resource: \(name).\(ext).")
        }
        
        guard let string = try? String(contentsOf: url, encoding: .utf8) else {
            fatalError("Corrupt string resource: \(name).\(ext).")
        }
        return string
    }

    func dataResource(named name: String, withExtension ext: String = "data", subdirectory: String? = nil) -> Data {
        guard let url = url(forResource: name, withExtension: ext, subdirectory: subdirectory) else {
            fatalError("Missing data resource: \(name).\(ext).")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Corrupt data resource: \(name).\(ext).")
        }
        return data
    }

    func jsonResource(named name: String, withExtension ext: String = "json", subdirectory: String? = nil, options: JSONSerialization.ReadingOptions = []) -> Any {
        let data = dataResource(named: name, withExtension: ext, subdirectory: subdirectory)
        guard let decoded = try? JSONSerialization.jsonObject(with: data, options: options) else {
            fatalError("Corrupt JSON resource: \(name).\(ext).")
        }
        return decoded
    }

    func hasFramework(named name: String) -> Bool {
        let url = bundleURL.appendingPathComponents(["Contents", "Frameworks", "SparkleBridgeClient.framework"])
        return FileManager.default.fileExists(atURL: url)
    }
}
