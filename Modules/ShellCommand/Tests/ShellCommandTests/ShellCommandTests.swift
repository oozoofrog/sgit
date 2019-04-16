import XCTest
@testable import ShellCommand

extension Result {
    var successValue: Success? {
        switch self {
        case let .success(success): return success
        default: return nil
        }
    }
}

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

    func testShellCommand() {
        let process = ShellCommand(command: "echo", arguments: [#"Hello"#])
        let result: Result<String, Error> = process.run()
        XCTAssertEqual(process.absoluteCommandPath, "/bin/echo")
        XCTAssertEqual(result.successValue, "Hello")
    }
    
    func testCustomCommand() {
        let bundlePath = Bundle(for: ShellCommandTests.self).bundlePath
        print(bundlePath)
    }

    static var allTests: [(String, () -> Void)] = []
}
