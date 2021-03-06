
import SemanticVersion
import XCTest
import XCTestExtensions
@testable import Bundles

final class BundlesTests: XCTestCase {
    /// Bundle to use for resource loading tests
    var bundle: Bundle { Bundle(url: testURL(named: "Test", withExtension: "bundle"))! }
    
    func testStringResource() {
        XCTAssertEqual(bundle.stringResource(named: "Test"), "String contents.")
    }
    
    func testDataResource() {
        if UserDefaults.standard.bool(forKey: "rewriteTestData") {
            let url = bundle.bundleURL.appendingPathComponent("Test.data")
            try! "String contents.".data(using: .utf8)!.write(to: url)
        } else {
            let data = bundle.dataResource(named: "Test")
            let string = String(data: data, encoding: .utf8)
            XCTAssertEqual(string, "String contents.")
        }
    }

    func testJSONResource() {
        let json: [String] = bundle.jsonResource(named: "Test")
        XCTAssertEqual(json, ["item 1", "item 2"])

    }

    func testDecodableResource() {
        struct Test: Decodable {
            let name: String
            let description: String
        }
        
        let data = bundle.decodeResource(Test.self, named: "Decodable")
        XCTAssertEqual(data.name, "Test")
        XCTAssertEqual(data.description, "Some test data")

    }

    func testInfoFromBundle() {
        let info = BundleInfo(for: bundle)
        XCTAssertEqual(info.name, "Name")
        XCTAssertEqual(info.id, "Identifier")
        XCTAssertEqual(info.build, 1234)
        XCTAssertEqual(info.version, SemanticVersion("1.2.3"))
        XCTAssertEqual(info.commit, "Commit")
        XCTAssertEqual(info.executable, "Executable")
        XCTAssertEqual(info.copyright, "Copyright")
    }

    func testInfoFromConstructor() {
        let info = BundleInfo(name: "Name", id: "Identifier", executable: "Executable", build: 1234, version: "1.2.3", commit: "Commit", copyright: "Copyright")
        XCTAssertEqual(info.name, "Name")
        XCTAssertEqual(info.id, "Identifier")
        XCTAssertEqual(info.build, 1234)
        XCTAssertEqual(info.version, SemanticVersion("1.2.3"))
        XCTAssertEqual(info.commit, "Commit")
        XCTAssertEqual(info.executable, "Executable")
        XCTAssertEqual(info.copyright, "Copyright")
    }

}
