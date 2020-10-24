public enum macOSVersion: Int, Hashable, Comparable {
    public static func < (lhs: macOSVersion, rhs: macOSVersion) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case v10_10
    case v10_11
    case v10_12
    case v10_13
    case v10_14
    case v10_15
    case v11
    
    public static var forcedVersion: macOSVersion?
    public static var preferredVersion: macOSVersion?
}

public class macOSPorter<Value> {
    private let defaultPort: Value
    private var ports: [macOSVersion: () -> Value] = [:]
    
    public var version: macOSVersion? {
        if let version = macOSVersion.forcedVersion {
            return version
        }
        
        if #available(macOS 11.0, *) {
            if let version = macOSVersion.preferredVersion,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v11] {
                return .v11
            }
        }
        
        if #available(macOS 10.15, *) {
            if let version = macOSVersion.preferredVersion,
               version <= .v10_15,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v10_15] {
                return .v10_15
            }
        }
        
        if #available(macOS 10.14, *) {
            if let version = macOSVersion.preferredVersion,
               version <= .v10_14,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v10_14] {
                return .v10_14
            }
        }
        
        if #available(macOS 10.13, *) {
            if let version = macOSVersion.preferredVersion,
               version <= .v10_13,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v10_13] {
                return .v10_13
            }
        }
        
        if #available(macOS 10.12, *) {
            if let version = macOSVersion.preferredVersion,
               version <= .v10_12,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v10_12] {
                return .v10_12
            }
        }
        
        if #available(macOS 10.11, *) {
            if let version = macOSVersion.preferredVersion,
               version <= .v10_11,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v10_11] {
                return .v10_11
            }
        }
        
        if #available(macOS 10.10, *) {
            if let version = macOSVersion.preferredVersion,
               version <= .v10_10,
               let _ = ports[version] {
                return version
            } else if let _ = ports[.v10_10] {
                return .v10_10
            }
        }
        
        return nil
    }
    public var value: Value {
        if let version = macOSVersion.forcedVersion {
            return ports[version]!()
        }
        
        guard let version = version else {
            return defaultPort
        }
        
        return ports[version]?() ?? defaultPort
    }
    
    public init(
        default port: Value
    ) {
        self.defaultPort = port
    }
    
    public func add(
        _ port: @autoclosure @escaping () -> Value,
        for version: macOSVersion
    ) {
        ports[version] = port
    }
}
