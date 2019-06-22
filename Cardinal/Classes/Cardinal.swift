//
//  Cardinal.swift
//  Cardinal
//
//  Created by Corey Roberts on 3/13/19.
//

import Foundation


/// Describes the severity of a message.
public enum LoggerLevel {
    
    case error, warning, info, debug, verbose, none
    
    var emojiValue: String {
        switch self {
        case .error:    return "🛑"
        case .warning:  return "🔶"
        case .info:     return "🔷"
        case .debug:    return "👾"
        case .verbose:  return "📗"
        case .none:     return ""
        }
    }
    
}


/// Describes the category that this message is attributed to.
/// To make a custom category not defined, `.category(String)` is provided for convenience.
public enum LoggerCategory: RawRepresentable, CustomStringConvertible {
    
    public typealias RawValue = String
    
    case none
    case lifecycle
    case network
    case ui
    case database
    case analytics
    
    case category(String)
    
    
    public init?(rawValue: String) {
        
        switch rawValue {
        case "none", "": self = .none
        case "lifecycle": self = .lifecycle
        case "network": self = .network
        case "ui": self = .ui
        case "db": self = .database
        case "analytics": self = .category(rawValue)
        default: self = .category(rawValue)
        }
        
    }
    
    public var rawValue: String {
        
        switch self {
        case .none: return ""
        case .lifecycle: return "lifecycle"
        case .network: return "network"
        case .ui: return "ui"
        case .database: return "db"
        case .analytics: return "analytics"
        case .category(let string): return string
        }
        
    }
    
    public var description: String {
        return "[\(rawValue.uppercased())]"
    }
    
}


/// Describes the different modes a logger can be in.
///
/// - synchronous: Messages will be processed synchronously.
/// - asynchronous: Messages will be processed asynchronously.
public enum LoggingMode {
    case synchronous, asynchronous
}


/// Describes an object that can log a message.
public protocol Loggable: Hashable {
    
    var mode: LoggingMode { get }
    var identifier: String { get }
    var queue: DispatchQueue { get }
    
    func log(file: String, function: String, level: String, category: String, message: String, args: CVaListPointer)

    static func ==(lhs: Self, rhs: Self) -> Bool
    
}

public extension Loggable {
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}


/// A managing class that handles the input and output of messages.
public final class Cardinal<T: Loggable> {
    
    private var loggers: Set<T> = Set<T>()
    
    convenience init(logger: T) {
        self.init(loggers: [logger])
    }
    
    public init(loggers: [T]) {
        self.loggers = Set(loggers)
    }
    
    /// Adds a logger to the system. If the logger is already included, this
    /// method does nothing.
    ///
    /// - Parameter logger: A `Loggable`.
    public func add(logger: T) {
        loggers.insert(logger)
    }
    
    
    /// Removes a logger from the system. If the logger was never included,
    /// this method does nothing.
    ///
    /// - Parameter logger: A `Loggable`.
    public func remove(logger: T) {
        loggers.remove(logger)
    }
    
    /// Logs a message through the different loggers installed.
    ///
    /// - Parameters:
    ///   - level: The level of the message. Defaults to `.verbose`.
    ///   - category: The category of the message. Defaults to `.none`.
    ///   - file: The file that this message was invoked. Defaults to `#file`.
    ///   - function: The function that this message was invoked. Defaults to `#function`.
    ///   - lineNumber: The line number that this message was invoked on. Defaults to `#line`.
    ///   - string: The message that was logged.
    public func log(level: LoggerLevel = .verbose, category: LoggerCategory = .none, file: String = #file, function: String = #function, lineNumber: Int = #line, string: String) {
        
        let logAction: ((T) -> ()) = { (logger) in
           
            let fileString: String = String(cString: strdup(file))
            let functionString: String = String(cString: strdup(function))
            
            let formattedString: String = "\(level.emojiValue) \(category.description) \(string)"
            let args: CVaListPointer = getVaList([formattedString])
            
            logger.log(file: fileString,
                       function: functionString,
                       level: level.emojiValue,
                       category: category.description,
                       message: string, args: args)
            
        }
        
        
        loggers.forEach { logAction($0) }
    }
    
}
