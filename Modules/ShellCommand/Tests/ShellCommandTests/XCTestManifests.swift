import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    if #available(macOS 10.13, *) {
        return [
            testCase(RunProcessTests.allTests),
        ]
    } else {
        return []
    }
}
#endif
