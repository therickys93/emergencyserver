import XCTest
@testable import LibraryTests

XCTMain([
	testCase(DataSourceTests.allTests),
	testCase(LocationTests.allTests),
])