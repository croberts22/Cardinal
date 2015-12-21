//
//  Logger.swift
//  Cardinal
//
//  Created by Corey Roberts.
//

import UIKit

class Log {
    
    class func log(severity: CardinalSeverity = .Debug, category: CardinalCategory = .Unspecified, file: String = __FILE__, function: String = __FUNCTION__, lineNumber: Int = __LINE__, @noescape closure: () -> String?) {
        
        if let string = closure() {
            
            // Convert String to UnsafePointer<Int8>.
            let cStringFile = strdup(file)

            Logger.log(severity, category: category, file: cStringFile, function: function, lineNumber: Int32(lineNumber), string: string)
        }
    }
    
    // MARK: Debug Logging Methods
    
    class func debug(category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func debug(category: CardinalCategory = .Unspecified, _ string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func debug(string: String?, category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Debug, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: Info Logging Methods
    
    class func info(category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Info, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func info(category: CardinalCategory = .Unspecified, _ string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Info, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func info(string: String?, category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Info, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: Warning Logging Methods
    
    class func warning(category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func warning(category: CardinalCategory = .Unspecified, _ string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func warning(string: String?, category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Warning, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    
    // MARK: Error Logging Methods
    
    class func error(category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__, closure: () -> String?) {
        log(.Error, category: category, file: file, function: function, lineNumber: lineNumber, closure: closure)
    }
    
    class func error(category: CardinalCategory = .Unspecified, _ string: String?, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Error, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
    class func error(string: String?, category: CardinalCategory = .Unspecified, function: String = __FUNCTION__, file: String = __FILE__, lineNumber: Int = __LINE__) {
        log(.Error, category: category, file: file, function: function, lineNumber: lineNumber, closure: {string})
    }
    
}
