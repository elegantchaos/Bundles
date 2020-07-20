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
    func stringResource(named name: String, withExtension ext: String = "txt", subdirectory: String? = nil) -> String {
        guard let url = url(forResource: name, withExtension: ext, subdirectory: subdirectory) else {
            resourceMissing(name: name, withExtension: ext, type: "string")
        }
        
        guard let string = try? String(contentsOf: url, encoding: .utf8) else {
            resourceCorrupt(name: name, withExtension: ext, type: "string")
        }
        return string
    }

    func dataResource(named name: String, withExtension ext: String = "data", subdirectory: String? = nil) -> Data {
        guard let url = url(forResource: name, withExtension: ext, subdirectory: subdirectory) else {
            resourceMissing(name: name, withExtension: ext, type: "data")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            resourceCorrupt(name: name, withExtension: ext, type: "data")
        }
        return data
    }

    func jsonResource<T>(named name: String, withExtension ext: String = "json", subdirectory: String? = nil, options: JSONSerialization.ReadingOptions = []) -> T {
        let data = dataResource(named: name, withExtension: ext, subdirectory: subdirectory)
        guard let decoded = try? JSONSerialization.jsonObject(with: data, options: options) else {
            resourceCorrupt(name: name, withExtension: ext, type: "json")
        }
        return decoded as! T
    }

    func decodeResource<T: Decodable>(_ type: T.Type, named name: String, withExtension ext: String = "json", subdirectory: String? = nil, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        let data = dataResource(named: name, withExtension: ext, subdirectory: subdirectory)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            resourceCorrupt(name: name, withExtension: ext, reason: "missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            resourceCorrupt(name: name, withExtension: ext, reason: "type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            resourceCorrupt(name: name, withExtension: ext, reason: "missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            resourceCorrupt(name: name, withExtension: ext, reason: "invalid JSON")
        } catch {
            resourceCorrupt(name: name, withExtension: ext, reason: error.localizedDescription)
        }
    }

    func hasFramework(named name: String) -> Bool {
        let url = bundleURL.appendingPathComponents(["Contents", "Frameworks", "\(name).framework"])
        return FileManager.default.fileExists(atURL: url)
    }
    
    fileprivate func resourceMissing(name: String, withExtension ext: String, type: String) -> Never {
        fatalError("Missing \(type) resource: \(name).\(ext).")
    }
    
    fileprivate func resourceCorrupt(name: String, withExtension ext: String, type: String? = nil, reason: String? = nil) -> Never {
        let resource = type == nil ? "resource" : "\(type!) resource"
        let fullName = ext.isEmpty ? name : "\(name).\(ext)"
        let extra = reason == nil ? "" : " \(reason!)"
        fatalError("Corrupt \(resource) \(fullName).\(extra)")

    }
}
