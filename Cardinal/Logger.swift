//
//  Logger.swift
//  iMapMy3
//
//  Created by Roberts, Corey on 8/20/15.
//  Copyright (c) 2015 MapMyFitness. All rights reserved.
//

import UIKit

class Log {
    
    class func log(severity: UALoggerSeverityLevel = .Debug, category: UALoggerCategory = .General, file: String = __FILE__, function: String = __FUNCTION__, lineNumber: Int = __LINE__, @noescape closure: () -> String?) {
        
        if let string = closure() {
            
            // Convert String to UnsafePointer<Int8>.
            let cStringFile = strdup(file)

            Logger.log(severity, category: category, file: cStringFile, function: function, lineNumber: Int32(lineNumber), string: string)
        }
    }
    
    // MARK: Debug Logging Methods
    
    class func debug(category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func debug(category: UALoggerCategory = .General, _ string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func debug(string: String?, category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: Info Logging Methods
    
    class func info(category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Info, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func info(category: UALoggerCategory = .General, _ string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Info, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func info(string: String?, category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Info, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: Warning Logging Methods
    
    class func warning(category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func warning(category: UALoggerCategory = .General, string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func warning(string: String?, category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: Error Logging Methods
    
    class func error(category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Error, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func error(category: UALoggerCategory = .General, _ string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Error, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func error(string: String?, category: UALoggerCategory = .General, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Error, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
}
