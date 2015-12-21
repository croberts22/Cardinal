//
//  ConsoleLogger.swift
//  Cardinal
//
//  Created by Corey Roberts.
//

import UIKit

class ConsoleLogger: NSObject, Loggable {

    var minimumToleranceLevel = CardinalSeverity.Debug
    let queue = dispatch_queue_create("com.cardinal.log-queue.consoleLogger", DISPATCH_QUEUE_SERIAL) as dispatch_queue_t
    
    var enableColors = false
    
    override init() {
        super.init()
        configureDefaultColors()
    }
    
    func write(message: LogMessage) {
        dispatch_async(queue, { () -> Void in
           
            /**
            * Using NSLog() instead of print() due to synchronicity issues, as well
            * as being able to read content on the device console versus the debugger.
            *
            * However, feel free to choose whichever method you prefer.
            *
            * :see: http://stackoverflow.com/a/25951564/692051 for more info.
            */
            
            // print(self.colorCodeIfNeeded(message))
            
            NSLog("%@", self.colorCodeIfNeeded(message))
        })
    }
    
    // MARK: - TTY Color Methods
    
    
    private func configureDefaultColors() {
        configureColor(.Debug, foregroundColor: UIColor.grayColor(), backgroundColor: UIColor.clearColor())
        configureColor(.Info, foregroundColor: UIColor.whiteColor(), backgroundColor: UIColor.clearColor())
        configureColor(.Warning, foregroundColor: UIColor.orangeColor(), backgroundColor: UIColor.clearColor())
        configureColor(.Error, foregroundColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor())
    }
    
    private func colorCodeIfNeeded(message: LogMessage) -> String {
        
        let string = message.stringValue(displayTimestamp: false)
        
        if enableColors {
            let colorCodedString = string
            
            return colorCodedString
        }
        
        return string
    }
    
    func configureColor(severity: CardinalSeverity, foregroundColor: UIColor, backgroundColor: UIColor) {

    }
}


private class XcodeColors {
    
}
