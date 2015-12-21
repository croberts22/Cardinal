//
//  ConsoleLogger.swift
//  iMapMy3
//
//  Created by Roberts, Corey on 7/14/15.
//  Copyright (c) 2015 MapMyFitness. All rights reserved.
//

import UIKit

class ConsoleLogger: NSObject, Loggable {

    var minimumToleranceLevel = UALoggerSeverityLevel.Debug
    let queue = dispatch_queue_create("com.mapmyfitness.log-queue.consoleLogger", DISPATCH_QUEUE_SERIAL) as dispatch_queue_t
    
    func write(message: LogMessage) {
        dispatch_async(queue, { () -> Void in
           
            /**
            * Using NSLog() instead of print() due to synchronicity issues, as well
            * as being able to read content on the device console versus the debugger.
            * :see: http://stackoverflow.com/a/25951564/692051 for more info.
            */
            // Fix the crash by ensuring that message.stringValue is always wrapped 
            // in an object before passing to NSLog.
            NSLog("%@", message.stringValue(displayTimestamp: false))
        })
    }
}
