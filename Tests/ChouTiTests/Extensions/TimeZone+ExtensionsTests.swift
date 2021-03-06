// Copyright © 2020 ChouTi. All rights reserved.

import XCTest
@testable import ChouTi

class TimeZone_ExtensionsTests: XCTestCase {
  func test() {
    XCTAssertEqual(TimeZone.gmt, TimeZone(abbreviation: "GMT")!)
    XCTAssertEqual(TimeZone.est, TimeZone(abbreviation: "EST")!)
    XCTAssertEqual(TimeZone.cst, TimeZone(abbreviation: "CST")!)
    XCTAssertEqual(TimeZone.mst, TimeZone(abbreviation: "MST")!)
    XCTAssertEqual(TimeZone.pst, TimeZone(abbreviation: "PST")!)
  }
}
