public enum iOSVersion: Hashable {
    case v11
    case v12
    case v13
    case v14
    
    public static var forcedVersion: iOSVersion?
    public static var preferredVersion: iOSVersion?
}

public class iOSPorter<Value> {
    private let defaultPort: Value
    private var ports: [iOSVersion: () -> Value] = [:]
    
    public var portVersion: iOSVersion? {
        if let version = iOSVersion.forcedVersion {
            return version
        }
        
        if #available(iOS 14.0, *) {
            if let version = iOSVersion.preferredVersion,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v14] {
                return .v14
            }
        }
        
        if #available(iOS 13.0, *) {
            if let version = iOSVersion.preferredVersion,
               version != .v14,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v13] {
                return .v13
            }
        }
        
        if #available(iOS 12.0, *) {
            if let version = iOSVersion.preferredVersion,
               version != .v14,
               version != .v13,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v12] {
                return .v12
            }
        }
        
        if #available(iOS 11.0, *) {
            if let version = iOSVersion.preferredVersion,
               version != .v14,
               version != .v13,
               version != .v12,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v11] {
                return .v11
            }
        }
        
        return nil
    }
    public var port: Value {
        if let version = iOSVersion.forcedVersion {
            return ports[version]!()
        }
        
        guard let version = portVersion else {
            return defaultPort
        }
        
        return ports[version]?() ?? defaultPort
    }
    
    public init(
        default port: Value
    ) {
        self.defaultPort = port
    }
    
    public func add(_ port: @autoclosure @escaping () -> Value, for version: iOSVersion) {
        ports[version] = port
    }
}
