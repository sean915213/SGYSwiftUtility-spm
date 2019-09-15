import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SGYSwiftUtility_spmTests.allTests),
    ]
}
#endif
