import XCTest

import sgitTests

var tests = [XCTestCaseEntry]()
tests += sgitTests.allTests()
XCTMain(tests)
