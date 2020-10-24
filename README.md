# UIPorter

iOS and macOS Version Value-Port; Use different values for different iOS or macOS versions.

## Basic iOSPorter Example

```swift
func testPorterVersion() {
    let porter = iOSPorter(default: "default value")
    
    porter.add("IOS 14", for: .v14)
    porter.add("IOS 13", for: .v13)
    porter.add("IOS 12", for: .v12)
    porter.add("IOS 11", for: .v11)
    
    if #available(iOS 14.0, *) {
        XCTAssertEqual(porter.value, "IOS 14")
        XCTAssertEqual(porter.version, .v14)
    } else if #available(iOS 13.0, *) {
        XCTAssertEqual(porter.value, "IOS 13")
        XCTAssertEqual(porter.version, .v13)
    } else if #available(iOS 12.0, *) {
        XCTAssertEqual(porter.value, "IOS 12")
        XCTAssertEqual(porter.version, .v12)
    } else if #available(iOS 11.0, *) {
        XCTAssertEqual(porter.value, "IOS 11")
        XCTAssertEqual(porter.version, .v11)
    } else {
        XCTAssert(false)
    }
    
    XCTAssertNotEqual(porter.value, "default value")
}
```

## Basic macOSPorter Example

```swift
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
```

## iOS Example

```swift
import UIKit
import SwiftUI
import UIPorter
import SwiftUIKit

class ViewController: UIViewController {
    let porter = iOSPorter(default: UIViewController { UIView(backgroundColor: .white).center { Label("default") }})

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            // Example: Uses @StateObject
            porter.add(UIHostingController(rootView: Text("Hello World 14")), for: .v14)
        } else if #available(iOS 13.0, *) {
            // Example: SwiftUI
            porter.add(UIHostingController(rootView: Text("Hello World 13")), for: .v13)
        }
        
        view.embed {
            ContainerView(parent: self) {
                porter.value
            }
        }
    }
}
```
