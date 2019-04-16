import XCTest
import ShellCommand
import class Foundation.Bundle

extension Result {
    var successValue: Success? {
        switch self {
        case let .success(value): return value
        default: return nil
        }
    }
}

@available(OSX 10.13, *)
final class sgitTests: XCTestCase {
    func testExample() throws {

        let fooBinary = productsDirectory.appendingPathComponent("sgit")
        let shell = ShellCommand(command: fooBinary.absoluteString)
        XCTAssertEqual(shell.run().successValue, "Hello, world!")
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
