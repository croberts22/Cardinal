//
//  Logger.swift
//  Cardinal
//
//  Created by Corey Roberts on 3/13/19.
//

import Foundation

public class Log {
    
    public class func log(_ severity: LoggerLevel = .debug, category: LoggerCategory = .none, file: String = #file, function: String = #function, lineNumber: Int = #line, closure: () -> String?) {
        
        if let string = closure() {
            
//            Logger.log(asynchronous: false,
//                       category: category,
//                       flag: severity,
//                       file: function,
//                       function: function,
//                       lineNumber: lineNumber,
//                       string: string)
        }
    }
    
    
    // MARK: - Verbose Logging Methods
    
    public class func verbose(_ category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        log(.verbose, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    public class func verbose(_ category: LoggerCategory = .none, _ string: String, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.verbose, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    public class func verbose(_ string: String, category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.verbose, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: - Debug Logging Methods
    
    public class func debug(_ category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        log(.debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    public class func debug(_ category: LoggerCategory = .none, _ string: String, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    public class func debug(_ string: String, category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: - Info Logging Methods
    
    public class func info(_ category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        log(.info, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    public class func info(_ category: LoggerCategory = .none, _ string: String, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.info, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    public class func info(_ string: String, category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.info, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: - Warning Logging Methods
    
    public class func warning(_ category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        log(.warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    public class func warning(_ category: LoggerCategory = .none, _ string: String, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    public class func warning(_ string: String, category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: - Error Logging Methods
    
    public class func error(_ category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line, closure: () -> String?) {
        log(.error, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    public class func error(_ category: LoggerCategory = .none, _ string: String, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.error, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    public class func error(_ string: String, category: LoggerCategory = .none, function: String = #function, file: String = #file, lineNumber: Int = #line) {
        log(.error, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
}
