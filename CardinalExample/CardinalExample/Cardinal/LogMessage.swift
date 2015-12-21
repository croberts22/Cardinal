//
//  LogMessage.swift
//  Cardinal
//
//  Created by Corey Roberts.
//

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
