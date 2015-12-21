//
// Cardinal.swift
//
// Copyright (c) 2015 Corey Roberts
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import UIKit

class Log {
    
    class func log(severity: CardinalSeverity = .Debug, category: CardinalCategory = .Unspecified, file: String = __FILE__, function: String = __FUNCTION__, lineNumber: Int = __LINE__, @noescape closure: () -> String?) {
        
        if let string = closure() {
            
            // Convert String to UnsafePointer<Int8>.
            let cStringFile = strdup(file)

            Cardinal.log(severity, category: category, file: cStringFile, function: function, lineNumber: Int32(lineNumber), string: string)
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
