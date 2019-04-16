import XCTest
@testable import RunProcess

@available(macOS 10.13, *)
final class RunProcessTests: XCTestCase {

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RunProcess().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
