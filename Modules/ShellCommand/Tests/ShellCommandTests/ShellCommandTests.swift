import XCTest
@testable import ShellCommand

@available(macOS 10.13, *)
final class ShellCommandTests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testFindCommandPath() {
        let result = ShellCommand(command: "echo")
        XCTAssertEqual(result.findFullPath(for: "echo"), "/bin/echo")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let process = ShellCommand(command: "echo", arguments: [#"Hello"#])
        let result: Result<String, Error> = process.run()
        switch result {
            case .failure(let error): XCTAssert(false, error.localizedDescription)
            case .success(let result): XCTAssertEqual(result, "Hello")
        }
    }

    static var allTests = [
        ("testFindCommandPath", testFindCommandPath),
        ("testExample", testExample),
    ]
}
