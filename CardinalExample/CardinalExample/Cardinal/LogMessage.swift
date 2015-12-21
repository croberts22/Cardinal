//
// LogMessage.swift
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

final class LogMessage: NSObject {
    
    var log = String()
    var severityLevel = CardinalSeverity.Debug
    var category = CardinalCategory.Unspecified
    var file = String()
    var function = String()
    var lineNumber = Int()
    
    let date = NSDate()
    
    static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS Z"
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        return formatter
    }()
    
    convenience init(log: String, severityLevel: CardinalSeverity, category: CardinalCategory, file: String, function: String, lineNumber: Int) {
        self.init()
        
        self.log = log
        self.severityLevel = severityLevel
        self.category = category
        self.file = file
        self.function = function
        self.lineNumber = lineNumber
    }
    
    func stringValue(displayTimestamp displayTimestamp: Bool = true) -> String {
        let formattedString = String(format: "%@(%ld) %@", function, lineNumber, log)
        
        let severityString = LogMessage.stringForLoggerSeverity(severityLevel)
        let categoryString = LogMessage.stringForLoggerCategory(category)
        
        var stringValue = displayTimestamp ? "\(LogMessage.dateFormatter.stringFromDate(date)): " : ""
    
        if let severityString = severityString {
            stringValue += severityString
        }
        
        if let categoryString = categoryString {
            stringValue += "[\(categoryString.uppercaseString)] "
        }
    
        stringValue += formattedString
        
        return stringValue
    }
    
    class func stringForLoggerCategory(category: CardinalCategory) -> String? {
        var string: String?
        
        switch (category) {
        case .Network:
            string = "Network"
        case .Database:
            string = "Database"
        case .UserInterface:
            string = "User Interface"
        case .Analytics:
            string = "Analytics"
        default:
            break
        }
        
        return string
    }
    
    class func stringForLoggerSeverity(severity: CardinalSeverity) -> String? {
        
        var string: String?
        
        switch (severity) {
        case .Warning:
            string = "\n\n*** WARNING ***\n\n"
        case .Error:
            string = "\n\n*************\n*** ERROR ***\n*************\n\n"
        default:
            break
        }
        
        return string
    }
    
}
