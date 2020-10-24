# UIPorter

iOS Version Value Port; Use different values for different iOS versions.

## Basic Example

```swift
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
                porter.port
            }
        }
    }
}
```
