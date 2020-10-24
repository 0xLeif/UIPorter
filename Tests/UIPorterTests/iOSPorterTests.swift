import XCTest
@testable import UIPorter

final class iOSPorterTests: XCTestCase {
    func testPorterVersion_default() {
        let porter = iOSPorter(default: "default value")
        
        XCTAssertNil(porter.portVersion)
        XCTAssertEqual(porter.port, "default value")
    }
    
    func testPorterVersion() {
        let porter = iOSPorter(default: "default value")
        
        porter.add("IOS 14", for: .v14)
        porter.add("IOS 13", for: .v13)
        porter.add("IOS 12", for: .v12)
        porter.add("IOS 11", for: .v11)
        
        if #available(iOS 14.0, *) {
            XCTAssertEqual(porter.port, "IOS 14")
            XCTAssertEqual(porter.portVersion, .v14)
        } else if #available(iOS 13.0, *) {
            XCTAssertEqual(porter.port, "IOS 13")
            XCTAssertEqual(porter.portVersion, .v13)
        } else if #available(iOS 12.0, *) {
            XCTAssertEqual(porter.port, "IOS 12")
            XCTAssertEqual(porter.portVersion, .v12)
        } else if #available(iOS 11.0, *) {
            XCTAssertEqual(porter.port, "IOS 11")
            XCTAssertEqual(porter.portVersion, .v11)
        } else {
            XCTAssert(false)
        }
        
        XCTAssertNotEqual(porter.port, "default value")
    }
    
    func testPorterForcedVersion() {
        defer {
            iOSVersion.forcedVersion = nil
        }
        iOSVersion.forcedVersion = .v11
        
        let porter = iOSPorter(default: "default value")
        
        porter.add("IOS 14", for: .v14)
        porter.add("IOS 13", for: .v13)
        porter.add("IOS 12", for: .v12)
        porter.add("IOS 11", for: .v11)
        
        XCTAssertEqual(porter.port, "IOS 11")
        XCTAssertEqual(porter.portVersion, .v11)
    }
    
    func testPorterPreferredVersion() {
        defer {
            iOSVersion.preferredVersion = nil
        }
        iOSVersion.preferredVersion = .v11
        
        let porter = iOSPorter(default: "default value")
        
        porter.add("IOS 14", for: .v14)
        porter.add("IOS 13", for: .v13)
        porter.add("IOS 12", for: .v12)
        porter.add("IOS 11", for: .v11)
        
        XCTAssertEqual(porter.port, "IOS 11")
        XCTAssertEqual(porter.portVersion, .v11)
    }
    
    func testPreferredPorter() {
        defer {
            iOSVersion.preferredVersion = nil
        }
        iOSVersion.preferredVersion = .v13
        
        let porter = iOSPorter(default: "default value")
        
        porter.add("IOS 14", for: .v14)
        porter.add("IOS 13", for: .v13)
        porter.add("IOS 12", for: .v12)
        porter.add("IOS 11", for: .v11)
        
        if #available(iOS 14.0, *) {
            XCTAssertEqual(porter.port, "IOS 13")
        } else if #available(iOS 13.0, *) {
            XCTAssertEqual(porter.port, "IOS 13")
        } else if #available(iOS 12.0, *) {
            XCTAssertEqual(porter.port, "IOS 12")
        } else if #available(iOS 11.0, *) {
            XCTAssertEqual(porter.port, "IOS 11")
        } else {
            XCTAssert(false)
        }
    }
    
    func testPreferredPorter_missingValue() {
        defer {
            iOSVersion.preferredVersion = nil
        }
        iOSVersion.preferredVersion = .v14
        
        let porter = iOSPorter(default: "default value")
        
        porter.add("IOS 13", for: .v13)
        porter.add("IOS 12", for: .v12)
        porter.add("IOS 11", for: .v11)
        
        if #available(iOS 14.0, *) {
            XCTAssertEqual(porter.port, "IOS 13")
        } else if #available(iOS 13.0, *) {
            XCTAssertEqual(porter.port, "IOS 13")
        } else if #available(iOS 12.0, *) {
            XCTAssertEqual(porter.port, "IOS 12")
        } else if #available(iOS 11.0, *) {
            XCTAssertEqual(porter.port, "IOS 11")
        } else {
            XCTAssert(false)
        }
    }
    
    static var allTests = [
        ("testPorterVersion_default", testPorterVersion_default),
        ("testPorterVersion", testPorterVersion),
        ("testPorterForcedVersion", testPorterForcedVersion),
        ("testPorterPreferredVersion", testPorterPreferredVersion),
        ("testPreferredPorter", testPreferredPorter),
        ("testPreferredPorter_missingValue", testPreferredPorter_missingValue)
    ]
}
