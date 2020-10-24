//
//  macOSPorterTests.swift
//  UIPorterTests
//
//  Created by Zach Eriksen on 10/24/20.
//

import XCTest
@testable import UIPorter

class macOSPorterTests: XCTestCase {
    func testPorterVersion_default() {
        let porter = macOSPorter(default: "default value")
        
        XCTAssertNil(porter.version)
        XCTAssertEqual(porter.value, "default value")
    }
    
    func testPorterVersion() {
        let porter = macOSPorter(default: "default value")
        
        porter.add("macOS 10.10", for: .v10_10)
        porter.add("macOS 10.11", for: .v10_11)
        porter.add("macOS 10.12", for: .v10_12)
        porter.add("macOS 10.13", for: .v10_13)
        porter.add("macOS 10.14", for: .v10_14)
        porter.add("macOS 10.15", for: .v10_15)
        porter.add("macOS 11", for: .v11)
        
        if #available(macOS 11.0, *) {
            XCTAssertEqual(porter.value, "macOS 11")
            XCTAssertEqual(porter.version, .v11)
        } else if #available(macOS 10.15, *) {
            XCTAssertEqual(porter.value, "macOS 10.15")
            XCTAssertEqual(porter.version, .v10_15)
        } else if #available(macOS 10.14, *) {
            XCTAssertEqual(porter.value, "macOS 10.14")
            XCTAssertEqual(porter.version, .v10_14)
        } else if #available(macOS 10.13, *) {
            XCTAssertEqual(porter.value, "macOS 10.13")
            XCTAssertEqual(porter.version, .v10_13)
        } else if #available(macOS 10.12, *) {
            XCTAssertEqual(porter.value, "macOS 10.12")
            XCTAssertEqual(porter.version, .v10_12)
        } else if #available(macOS 10.11, *) {
            XCTAssertEqual(porter.value, "macOS 10.11")
            XCTAssertEqual(porter.version, .v10_11)
        } else if #available(macOS 10.10, *) {
            XCTAssertEqual(porter.value, "macOS 10.10")
            XCTAssertEqual(porter.version, .v10_10)
        } else {
            XCTAssert(false)
        }
        
        XCTAssertNotEqual(porter.value, "default value")
    }
    
    
    static var allTests = [
        ("testPorterVersion_default", testPorterVersion_default),
        ("testPorterVersion", testPorterVersion)
    ]
}
