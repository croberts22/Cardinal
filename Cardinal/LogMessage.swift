//
//  LogMessage.swift
//  iMapMy3
//
//  Created by Roberts, Corey on 7/15/15.
//  Copyright (c) 2015 MapMyFitness. All rights reserved.
//

import UIKit

// TODO: Change this to a struct once Logger is written in Swift.
class LogMessage: NSObject {
    
    var log = String()
    var severityLevel = UALoggerSeverityLevel.Debug
    var category = UALoggerCategory.General
    var file = String()
    var function = String()
    var lineNumber = Int()
    
    let date = NSDate()
    
    convenience init(log: String, severityLevel: UALoggerSeverityLevel, category: UALoggerCategory, file: String, function: String, lineNumber: Int) {
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
        
        var stringValue = displayTimestamp ? "\(NSDateFormatter.logFormatter().stringFromDate(date)): " : ""
    
        if let severityString = severityString {
            stringValue += severityString
        }
        
        if let categoryString = categoryString {
            stringValue += "[\(categoryString.uppercaseString)] "
        }
    
        stringValue += formattedString
        
        return stringValue
    }
    
    
    class func stringForLoggerCategory(category: UALoggerCategory) -> String? {
        var string: String?
        
        // TODO: If enum ever gets ported into Swift, use enum -> String valuation
        // instead of this switch statement.
        switch (category) {
        case .Network:
            string = "Network"
        case .Database:
            string = "Database"
        case .Bluetooth:
            string = "Bluetooth"
        case .Permissions:
            string = "Permissions"
        case .Validation:
            string = "Validation"
        default:
            break
        }
        
        return string
    }
    
    class func stringForLoggerSeverity(severity: UALoggerSeverityLevel) -> String? {
        
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
